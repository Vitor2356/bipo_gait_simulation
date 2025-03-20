clc
close all

% T = Q.time;
% xstance = zeros(length(T),1);
% ystance = zeros(length(T),1);


numberOfFramesStep = 100;
decim = floor(length(Qt(:,1))/(numSteps*numberOfFramesStep));

% Q1 = Q.signals.values(:,1);
% Q2 = Q.signals.values(:,2);
% Q3 = Q.signals.values(:,3);
% Q4 = Q.signals.values(:,4);
% Q5 = Q.signals.values(:,5);

Q1 = Qt(:,1);
Q2 = Qt(:,2);
Q3 = Qt(:,3);
Q4 = Qt(:,4);
Q5 = Qt(:,5);

figure
xlim([-2*(l1+l2),2*(l1+l2)])
ylim([-l1, 2*(l1+l2)])
hold on
% X = [0.15, 0.15, 0.30, 0.30, 0.15];
% Y = [0.00, 0.15, 0.15, 0.00, 0.00];
% plot(X,Y, 'r')
R = plot(0,0);
a = plot(0,0);
b = plot(0,0);
c = plot(0,0);
d = plot(0,0);
e = plot(0,0);
F = [];

%v = VideoWriter('myRobot.avi');
%v.FrameRate = ceil(length(T)/decim)/(T(end));
%open(v);
grid minor

% Tpause = (T(end) - T(1))/(decim*10*numSteps);
Tpause = 0.005;

for I=0:floor(length(Q1)/decim)
    i = decim*I;
    
    if(i == 0)
        i = 1;
    end
    
    O = [xstance(i),ystance(i)];
    
    alpha1 = Q1(i);
    alpha2 = alpha1 + Q2(i);
    alpha3 = alpha2 + Q3(i);
    alpha4 = alpha3 + Q4(i);
    alpha5 = alpha4 + Q5(i);
    
    A = O + [l1*cos(alpha1), l1*sin(alpha1)];
    B = A + [l2*cos(alpha2), l2*sin(alpha2)];
    C = B + [l3*cos(alpha3), l3*sin(alpha3)];
    D = B + [l4*cos(alpha4), l4*sin(alpha4)];
    E = D + [l5*cos(alpha5), l5*sin(alpha5)];
    
    Pos = [O', A', B', C', B', D', E'];
    
    plot(O(1), O(2), 'rX')
    
    delete(R)
    delete(a)
    delete(b)
    delete(c)
    delete(d)
    delete(e)
    
    R = plot(Pos(1,:), Pos(2,:), 'b');
    a = plot(A(1), A(2), 'rX');
    b = plot(B(1), B(2), 'bX');
    c = plot(C(1), C(2), 'kX');
    d = plot(D(1), D(2), 'gX');
    e = plot(E(1), E(2), 'cX');
    
    xlim([-2*(l1+l2) + B(1),2*(l1+l2) + B(1)])
    ylim([-l1, 2*(l1+l2)])
    
    pause(Tpause)
    
    
    
    %fFrame  = getframe;
    %writeVideo(v,fFrame)
end

i = length(Q1);
    
if(i == 0)
    i = 1;
end

O = [xstance(i),ystance(i)];

alpha1 = Q1(i);
alpha2 = alpha1 + Q2(i);
alpha3 = alpha2 + Q3(i);
alpha4 = alpha3 + Q4(i);
alpha5 = alpha4 + Q5(i);

A = O + [l1*cos(alpha1), l1*sin(alpha1)];
B = A + [l2*cos(alpha2), l2*sin(alpha2)];
C = B + [l3*cos(alpha3), l3*sin(alpha3)];
D = B + [l4*cos(alpha4), l4*sin(alpha4)];
E = D + [l5*cos(alpha5), l5*sin(alpha5)];

Pos = [O', A', B', C', B', D', E'];

plot(O(1), O(2), 'rX')

%     delete(R)
%     delete(a)
%     delete(b)
%     delete(c)
%     delete(d)
%     delete(e)

R = plot(Pos(1,:), Pos(2,:), 'b');
a = plot(A(1), A(2), 'rX');
b = plot(B(1), B(2), 'bX');
c = plot(C(1), C(2), 'kX');
d = plot(D(1), D(2), 'gX');
e = plot(E(1), E(2), 'cX');
pause(Tpause)

%fFrame  = getframe;
%writeVideo(v,fFrame)

%close(v)