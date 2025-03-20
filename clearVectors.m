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

stoperror(curSim) = false;
