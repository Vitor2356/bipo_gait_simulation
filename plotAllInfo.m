
desL = 420;
desH = 300;

%% S

if(curSim > 1)
    %%% S1
    figure(1)
    mult = 0.2;     %Adjust to screen size
    porp = 23.62;   %pixels/mm
    porp = porp*mult;
    leftMargin = 30;        %Left Margin
    rightMargin = 20;        %Right Margin
    ps = desL;       %Length of A4
    dh = desH;       %Desired Height
    x0=30;
    y0=70;
    width=(ps-leftMargin-rightMargin)*porp;
    height=dh*porp;
    set(gcf,'position',[x0,y0,width,height])
    
    subplot(4,(totSims-1), (curSim-1) + (1-1)*(totSims-1))
    plot(Tdisc, St(:,1))
    grid minor
    %xlim([ti(1) - 0.01, ti(1)+0.05])
    if(curSim == 2)
        LABEL = ylabel('$S_{Qt}$');
        set(LABEL, 'interpreter', 'latex', 'FontSize', 14)
        title('Distance to the Sliding Surface for SMC', 'FontSize', 20)
    else
        title('Distance to the Sliding Surface for Extended SMC', 'FontSize', 20)
    end
%     leg1 = legend('$S_{Qt}$', '$\phi$');
%     set(leg1, 'interpreter', 'latex')
    
    %%% S2
    
    subplot(4,(totSims-1), (curSim-1) + (2-1)*(totSims-1))
    plot(Tdisc, St(:,2))
    grid minor
    %xlim([ti(1) - 0.01, ti(1)+0.05])
    if(curSim == 2)
        LABEL = ylabel('$S_{Psw_y}$');
        set(LABEL, 'interpreter', 'latex', 'FontSize', 14)
    end
%     leg2 = legend('$S_{Psw_y}$', '$\phi$');
%     set(leg2, 'interpreter', 'latex')
    
    %%% S3
    
    subplot(4,(totSims-1), (curSim-1) + (3-1)*(totSims-1))
    plot(Tdisc, St(:,3))
    grid minor
    %xlim([ti(1) - 0.01, ti(1)+0.05])
    if(curSim == 2)
        LABEL = ylabel('$S_{CoM_y}$');
        set(LABEL, 'interpreter', 'latex', 'FontSize', 14)
    end
%     leg3 = legend('$S_{CoM_y}$', '$\phi$');
%     set(leg3, 'interpreter', 'latex')
    
    %%% S4
    
    subplot(4,(totSims-1), (curSim-1) + (4-1)*(totSims-1))
    plot(Tdisc, St(:,4))
    grid minor
    %xlim([ti(1) - 0.01, ti(1)+0.05])
    xlabel('Time (s)')
    if(curSim == 2)
        LABEL = ylabel('$S_{Psw_x}$');
        set(LABEL, 'interpreter', 'latex', 'FontSize', 14)
    end
%     leg4 = legend('$S_{Psw_x}$', '$\phi$');
%     set(leg4, 'interpreter', 'latex')
end

%% Q

%%% Q1
figure(2)
mult = 0.2;     %Adjust to screen size
porp = 23.62;   %pixels/mm
porp = porp*mult;
leftMargin = 30;        %Left Margin
rightMargin = 20;        %Right Margin
ps = desL;       %Length of A4
dh = desH;       %Desired Height
x0=30;
y0=70;
width=(ps-leftMargin-rightMargin)*porp;
height=dh*porp;
set(gcf,'position',[x0,y0,width,height])

subplot(5,(totSims), (curSim) + (1-1)*(totSims))
plot(T, Qt(:,1))
grid minor
if(curSim == 1)
    ylabel('Q1 (rad)')
    title('Angular Position for FL')
else
    if(curSim == 2)
        title('Angular Position for SMC')
    else
        title('Angular Position for Extended SMC')
    end
end
% leg1 = legend('$Q_{1_{flat}}$', '$Q_1$');
% set(leg1, 'interpreter', 'latex')

%%% Q2

subplot(5,(totSims), (curSim) + (2-1)*(totSims))
plot(T, Qt(:,2))
grid minor
if(curSim == 1)
  ylabel('Q2 (rad)')
end
% leg2 = legend('$Q_{2_{flat}}$', '$Q_2$');
% set(leg2, 'interpreter', 'latex')

%%% Q3

subplot(5,(totSims), (curSim) + (3-1)*(totSims))
plot(T, Qt(:,3))
grid minor
if(curSim == 1)
  ylabel('Q3 (rad)')
end
% leg3 = legend('$Q_{3_{flat}}$', '$Q_3$');
% set(leg3, 'interpreter', 'latex')

%%% Q4

subplot(5,(totSims), (curSim) + (4-1)*(totSims))
plot(T, Qt(:,4))
grid minor
if(curSim == 1)
  ylabel('Q4 (rad)')
end
% leg4 = legend('$Q_{4_{flat}}$', '$Q_4$');
% set(leg4, 'interpreter', 'latex')

%%% Q5

subplot(5,(totSims), (curSim) + (5-1)*(totSims))
plot(T, Qt(:,5))
grid minor
xlabel('Time (s)')
if(curSim == 1)
  ylabel('Q5 (rad)')
end
% leg5 = legend('$Q_{5_{flat}}$', '$Q_5$');
% set(leg5, 'interpreter', 'latex')

%% dQ

%%% dQ1
figure(3)
mult = 0.2;     %Adjust to screen size
porp = 23.62;   %pixels/mm
porp = porp*mult;
leftMargin = 30;        %Left Margin
rightMargin = 20;        %Right Margin
ps = desL;       %Length of A4
dh = desH;       %Desired Height
x0=30;
y0=70;
width=(ps-leftMargin-rightMargin)*porp;
height=dh*porp;
set(gcf,'position',[x0,y0,width,height])

subplot(5,(totSims), (curSim) + (1-1)*(totSims))
plot(T, dQt(:,1))
grid minor
ylabel('dQ1 (rad/s)')
if(curSim == 1)
    ylabel('dQ1 (rad/s)')
    title('Angular Velocity for FL')
else
    if(curSim == 2)
        title('Angular Velocity for SMC')
    else
        title('Angular Velocity for Extended SMC')
    end
end
% leg1 = legend('$dQ_{1_{flat}}$', '$dQ_1$');
% set(leg1, 'interpreter', 'latex')

%%% dQ2

subplot(5,(totSims), (curSim) + (2-1)*(totSims))
plot(T, dQt(:,2))
grid minor
if(curSim == 1)
  ylabel('dQ2 (rad/s)')
end
% leg2 = legend('$dQ_{2_{flat}}$', '$dQ_2$');
% set(leg2, 'interpreter', 'latex')

%%% dQ3

subplot(5,(totSims), (curSim) + (3-1)*(totSims))
plot(T, dQt(:,3))
grid minor
if(curSim == 1)
  ylabel('dQ3 (rad/s)')
end
% leg3 = legend('$dQ_{3_{flat}}$', '$dQ_3$');
% set(leg3, 'interpreter', 'latex')

%%% dQ4

subplot(5,(totSims), (curSim) + (4-1)*(totSims))
plot(T, dQt(:,4))
grid minor
if(curSim == 1)
  ylabel('dQ4 (rad/s)')
end
% leg4 = legend('$dQ_{4_{flat}}$', '$dQ_4$');
% set(leg4, 'interpreter', 'latex')

%%% dQ5

subplot(5,(totSims), (curSim) + (5-1)*(totSims))
plot(T, dQt(:,5))
grid minor
xlabel('Time (s)')
if(curSim == 1)
  ylabel('dQ5 (rad/s)')
end
% leg5 = legend('$dQ_{5_{flat}}$', '$dQ_5$');
% set(leg5, 'interpreter', 'latex')

%% U

%%% U2      Since the robot is underactuated, U1==0
figure(4)
mult = 0.2;     %Adjust to screen size
porp = 23.62;   %pixels/mm
porp = porp*mult;
leftMargin = 30;        %Left Margin
rightMargin = 20;        %Right Margin
ps = desL;       %Length of A4
dh = desH;       %Desired Height
x0=30;
y0=70;
width=(ps-leftMargin-rightMargin)*porp;
height=dh*porp;
set(gcf,'position',[x0,y0,width,height])

subplot(4,(totSims), (curSim) + (1-1)*(totSims))
plot(Tdisc, Ut(:,2))
grid minor
if(curSim == 1)
    ylabel('U2 (N.m)')
    title('Control signal for FL')
else
    if(curSim == 2)
        title('Control signal for SMC')
    else
        ylabel('U2 (Volts)')
        title('Control signal for Extended SMC')
    end
end

%%% U3

subplot(4,(totSims), (curSim) + (2-1)*(totSims))
plot(Tdisc, Ut(:,3))
grid minor
if(curSim == 1)
  ylabel('U3 (N.m)')
else
    if(curSim == 3)
        ylabel('U3 (Volts)')
    end
end

%%% U4

subplot(4,(totSims), (curSim) + (3-1)*(totSims))
plot(Tdisc, Ut(:,4))
grid minor
if(curSim == 1)
  else
    if(curSim == 3)
        ylabel('U4 (Volts)')
    end
end
%%% U5

subplot(4,(totSims), (curSim) + (4-1)*(totSims))
plot(Tdisc, Ut(:,5))
grid minor
xlabel('Time (s)')
if(curSim == 1)
  ylabel('U5 (N.m)')
else
    if(curSim == 3)
        ylabel('U5 (Volts)')
    end
end

%% Yout & xCoM
figure(5)
mult = 0.2;     %Adjust to screen size
porp = 23.62;   %pixels/mm
porp = porp*mult;
leftMargin = 30;        %Left Margin
rightMargin = 20;        %Right Margin
ps = desL;       %Length of A4
dh = desH;       %Desired Height
x0=30;
y0=70;
width=(ps-leftMargin-rightMargin)*porp;
height=dh*porp;
set(gcf,'position',[x0,y0,width,height])

%Y(1) = Qt
subplot(5,(totSims), (curSim) + (1-1)*(totSims))
plot(Tdisc, Yout(:,1))
hold on
plot(Tdisc, Ydes(:,1))
grid minor
if(curSim == 1)
    LABEL = ylabel('$Y_{out}(1) = Q_t$');
    set(LABEL, 'interpreter', 'latex')
    title('FL')
else
    if(curSim == 2)
        title('SMC')
    else
        title('Extended SMC')
    end
end
leg1 = legend('$Q_{t}$', '$Q_{t_d}$');
set(leg1, 'interpreter', 'latex')

%Y(2) = Pswy
subplot(5,(totSims), (curSim) + (2-1)*(totSims))
plot(Tdisc, Yout(:,2))
hold on
plot(Tdisc, Ydes(:,2))
grid minor
if(curSim == 1)
    LABEL = ylabel('$Y_{out}(2) = Psw_{y}$');
    set(LABEL, 'interpreter', 'latex')
end
leg1 = legend('$Psw_{y}$', '$Psw_{y_d}$');
set(leg1, 'interpreter', 'latex')

%Y(3) = CoMy
subplot(5,(totSims), (curSim) + (3-1)*(totSims))
plot(Tdisc, Yout(:,3))
hold on
plot(Tdisc, Ydes(:,3))
grid minor
if(curSim == 1)
    LABEL = ylabel('$Y_{out}(3) = CoM_{y}$');
    set(LABEL, 'interpreter', 'latex')
end
leg1 = legend('$CoM_{y}$', '$CoM_{y_d}$');
set(leg1, 'interpreter', 'latex')

%Y(4) = Pswx
subplot(5,(totSims), (curSim) + (4-1)*(totSims))
plot(Tdisc, Yout(:,4))
hold on
plot(Tdisc, Ydes(:,4))
grid minor
if(curSim == 1)
    LABEL = ylabel('$Y_{out}(4) = Psw_{x}$');
    set(LABEL, 'interpreter', 'latex')
end
leg1 = legend('$Psw_{x}$', '$Psw_{x_d}$');
set(leg1, 'interpreter', 'latex')

%CoMx
subplot(5,(totSims), (curSim) + (5-1)*(totSims))
plot(Tdisc, xCoM)
grid minor
% if(curSim == 1)
%     LABEL = ylabel('$CoM_{x}$');
%     set(LABEL, 'interpreter', 'latex')
%     title('FL')
% else
%     if(curSim == 2)
%         title('SMC')
%     else
%         title('Extended SMC')
%     end
% end
xlabel('Time (s)')
leg1 = legend('$CoM_{x}$');
set(leg1, 'interpreter', 'latex')