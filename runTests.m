clearvars
close all
clc

% Defines control Gains
%FL
LambdaFL = [150; 150; 150; 150];

%% SMC
KSMC      = [1; 1; 1; 1];
LambdaSMC = [300; 150; 100; 150];
%LambdaSMC = [300; 150; 100; 150];
PhiSMC    = [0.45; 0.45; 0.45; 0.45].*KSMC;
KappaSMC  = [150; 150; 100; 200];

%% SMC extended
KSMCex      = [1; 1; 1; 1];
LambdaSMCex = [300; 250; 150; 200];
% PhiSMCex    = [5; 1; 1; 8].*KSMCex;
PhiSMCex    = [10; 10; 10; 20].*KSMCex;
KappaSMCex  = [6000; 5000; 5000; 20000];

%% Simulation parameters
numSteps = 5;      % Number of steps to perform in the simulation
Inc = 0;            % Inclination of the floor
checkStep = 5;      % Step at which boundary conditions start to be taken into consideration

Tpasso = 0.35;   	%Desired duration of a step.

%Model parameters
g = 9.81;           %gravity vector

m1 = 0.254;         % Mass of the link
m2 = 0.78;
m3 = 3.861;
m4 = m2;
m5 = m1;

I1 = 4.3362*10^-4;  % Inertia of the link
I2 = 8.7409*10^-4;
I3 = 1.4148*10^-2;
I4 = I2;
I5 = I1;

l1 = 0.15;          % Length of the link
l2 = 0.15;
l3 = 0.2095;
l4 = l2;
l5 = l1;

c1 = 0.059982;      % Distance of the center of mass
c2 = 0.065276;
c3 = 0.071259;
c4 = c2;
c5 = c1;

Cphi = 1;           % Viscous friction coefficient of the joints

%Floor Friction
floorfric = 0.6;

%Motor Parameters
Ra = 1;
La = 1e-3;
Kt = 0.1;
Bm = 1e-4;
Jm = 5e-3;
Satur = 11.3;

%Creates the vectors of model and real parameters
gr = g;
gm = g;

mr = [m1; m2; m3; m4; m5];
mm = [m1; m2; m3; m4; m5];

Ir = [I1; I2; I3; I4; I5];
Im = [I1; I2; I3; I4; I5];

cr = [c1; c2; c3; c4; c5];
cm = [c1; c2; c3; c4; c5];

lr = [l1; l2; l3; l4; l5];
lm = [l1; l2; l3; l4; l5];

%Initial conditions on the gait
Q0   = [pi/2 - pi/10; pi/5; 2*pi-pi/10; pi+pi/10; -pi/4.5];
dQ0  = zeros(5,1);
ddQ0 = zeros(5,1);

%Arrays to store the results of the simulations
Ut      = [];       %Control signal resulting of the main controller, before motor PI
St      = [];       %Sliding surface, when applicable
Qt      = [];       %Angular positions
dQt     = [];       %Angular velocities
T       = [];       %Total time vector of the continuous part of the simulation
Tdisc   = [];       %Total time vector of the discrete part of the simulation
ti      = [];       %Impact times
xstance = [];       %Position x of the stance leg
ystance = [];       %Position y of the stance leg
lstep   = [];       %Step length vector
CPpos   = [];       %Position of the capture point
Yout    = [];       %Position of the controlled variables
Ydes    = [];       %Reference position of the controlled variables
xCoM    = [];       %Position x of the CoM. Note that this is a free variable, meaning its position is not directly controlled, but is used in the computation of the capture point. For this reason we close the system with 5 equations for 5 variables.
stoperror = [false, false, false];

%Initial time
t0 = 0;

%Initial position of the stance feet on the first step
xstance0 = 0;
ystance0 = 0;

%%% Terrain parameters
mInc = tan(Inc*pi/180);

% Sampling times and max simulation step size
TsC   = 0.003;      % 300Hz minimum for higher level control
TsPID = 1/1000;     % 1 kHz for the internal PID loop
Tsim  = 1e-4;       % Max step size on the simulation

%States that we want to perform a step, not mantain a position
gait = 1;

%States that the current simulation does not use noise
useNoise = false;

%States that the current simulation does not want to use perturbation on
%any step. Perturbation is heaviside-like.
pertStep = 0;       %If pert step = 0, we will not apply any push on the simulation
pertAmp  = 0;
pertDur  = 0;

%Load Model's Matrices
load('Vars/robotsModel.mat')

%Inputs the desired simulations to run. We count from 1 to the input number
% 1 = FL
% 2 = SMC
% 3 = Extended SMC
totSims = 3;

% Simple permutation of all perturbations
runNoErrorNoNoiseNoIncNoFext;
% runErrorNoNoiseNoIncNoFext;
% runNoErrorNoiseNoIncNoFext;
% runNoErrorNoNoiseUpIncNoFext;
% runNoErrorNoNoiseDownIncNoFext;
% runNoErrorNoNoiseNoIncFext;
% 
% % All pertubations at once, except one
% runErrorNoiseUpIncNoFext;
% runErrorNoiseDownIncNoFext;
% runErrorNoNoiseUpIncFext;
% 
% % All pertubations at once, including push
% runErrorNoiseUpIncFext;         %%Adding a push to the system with all this diffilculty might be too much. We decrease the intensity of the push here.