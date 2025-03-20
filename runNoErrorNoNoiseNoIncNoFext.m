close all
clc

cond = 'NoErrorNoNoiseNoIncNoFext';

totRMSE   = [];
totEnergy = [0;0;0];

%% Output based FL

if(totSims >= 1)
    curSim  = 1;
    
    clearVectors
    t0 = 0;
    Q0   = [pi/2 - pi/10; pi/5; 2*pi-pi/10; pi+pi/10; -pi/4.5];
    dQ0  = zeros(5,1);
    ddQ0 = zeros(5,1);
    
    for curStep =1:numSteps
        disp('Starting the simulation step for FL')

        sim('FeedbackLin.slx')

        Ut      = [Ut; Uc.signals.values];
        Qt      = [Qt; Q.signals.values];
        dQt     = [dQt; dQ.signals.values];
        T       = [T; Q.time + t0];
        Tdisc   = [Tdisc; Uc.time + t0];

        t0 = t0 + Q.time(end);

        ti = [ti; t0];

        xstance = [xstance; ones(length(Q.signals.values(:,1)), 1)*xstance0];
        ystance = [ystance; ones(length(Q.signals.values(:,1)), 1)*ystance0];

        xstance0 = xstance0 + l1*cos(Qt(end,1)) + l2*cos(Qt(end,1) + Qt(end,2)) + l4*cos(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4)) + l5*cos(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4) + Qt(end,5));
        ystance0 = ystance0 + l1*sin(Qt(end,1)) + l2*sin(Qt(end,1) + Qt(end,2)) + l4*sin(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4)) + l5*sin(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4) + Qt(end,5));

        lstep = [lstep; (xstance0 - xstance(end))];
        CPpos = [CPpos; CP.signals.values];

        Yout  = [Yout; Y.signals.values];
        Ydes  = [Ydes; Yd.signals.values];

        xCoM  = [xCoM; XCoM.signals.values];

        totEnergy(1) = totEnergy(1) + Energy.signals.values(end);
        
        if(gait)
            [Qp, dQp, F2, pa_d, stoperror] = calcImpact(dQ.signals.values(end,:), Q.signals.values(end,:), gr, mr, Ir, cr, lr, mInc, D_e_imp, E_imp, varNames, floorfric, stoperror, curSim, curStep, checkStep);

            Q10 = Qp(1);
            Q20 = Qp(2);
            Q30 = Qp(3);
            Q40 = Qp(4);
            Q50 = Qp(5);

            dQ10 = dQp(1);
            dQ20 = dQp(2);
            dQ30 = dQp(3);
            dQ40 = dQp(4);
            dQ50 = dQp(5);

            Q0   = [Q10; Q20; Q30; Q40; Q50];
            dQ0  = [dQ10; dQ20; dQ30; dQ40; dQ50];

            % Checks the force at the moment of the impact
            
        end
        calcFreact;
        if((stoperror(curSim) == true) && (curStep >= checkStep))
            break;
        end
    end

    RMSEy = sqrt(sum((Yout - Ydes).^2)/length(Yout(:,1)));
    totRMSE = [totRMSE;RMSEy];
    
    mkdir(['Results/', cond, '/FL'])
    save(['Results/', cond, '/FL/Results.mat'], 'St', 'Ut', 'Qt', 'dQt', 'T', 'Tdisc', 'ti', 'xstance', 'ystance', 'lstep', 'CPpos', 'Yout', 'Ydes', 'xCoM', 'RMSEy', 'totEnergy')

    plotAllInfo
    
    figure(99)
    hold on
    plot(lstep)
end

%% Output based SMC

if(totSims >= 2)
    curSim  = 2;
    
    clearVectors
    t0 = 0;
    Q0   = [pi/2 - pi/10; pi/5; 2*pi-pi/10; pi+pi/10; -pi/4.5];
    dQ0  = zeros(5,1);
    ddQ0 = zeros(5,1);
    
    for curStep =1:numSteps
        disp('Starting the simulation step for SMC')

        sim('OutputbasedSlidingmode.slx')

        Ut      = [Ut; Uc.signals.values];
        St      = [St; S.signals.values];
        Qt      = [Qt; Q.signals.values];
        dQt     = [dQt; dQ.signals.values];
        T       = [T; Q.time + t0];
        Tdisc   = [Tdisc; Uc.time + t0];

        t0 = t0 + Q.time(end);

        ti = [ti; t0];

        xstance = [xstance; ones(length(Q.signals.values(:,1)), 1)*xstance0];
        ystance = [ystance; ones(length(Q.signals.values(:,1)), 1)*ystance0];

        xstance0 = xstance0 + l1*cos(Qt(end,1)) + l2*cos(Qt(end,1) + Qt(end,2)) + l4*cos(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4)) + l5*cos(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4) + Qt(end,5));
        ystance0 = ystance0 + l1*sin(Qt(end,1)) + l2*sin(Qt(end,1) + Qt(end,2)) + l4*sin(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4)) + l5*sin(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4) + Qt(end,5));

        lstep = [lstep; (xstance0 - xstance(end))];
        CPpos = [CPpos; CP.signals.values];

        Yout  = [Yout; Y.signals.values];
        Ydes  = [Ydes; Yd.signals.values];

        xCoM  = [xCoM; XCoM.signals.values];

        totEnergy(2) = totEnergy(2) + Energy.signals.values(end);
        
        if(gait)
            [Qp, dQp, F2, pa_d, stoperror] = calcImpact(dQ.signals.values(end,:), Q.signals.values(end,:), gr, mr, Ir, cr, lr, mInc, D_e_imp, E_imp, varNames, floorfric, stoperror, curSim, curStep, checkStep);

            Q10 = Qp(1);
            Q20 = Qp(2);
            Q30 = Qp(3);
            Q40 = Qp(4);
            Q50 = Qp(5);

            dQ10 = dQp(1);
            dQ20 = dQp(2);
            dQ30 = dQp(3);
            dQ40 = dQp(4);
            dQ50 = dQp(5);

            Q0   = [Q10; Q20; Q30; Q40; Q50];
            dQ0  = [dQ10; dQ20; dQ30; dQ40; dQ50];

        end
        calcFreact;
        if((stoperror(curSim) == true) && (curStep >= checkStep))
            break;
        end
    end

    RMSEy = sqrt(sum((Yout - Ydes).^2)/length(Yout(:,1)));
    totRMSE = [totRMSE;RMSEy];
    
    mkdir(['Results/', cond, '/SMC'])
    save(['Results/', cond, '/SMC/Results.mat'], 'Ut', 'St', 'Qt', 'dQt', 'T', 'Tdisc', 'ti', 'xstance', 'ystance', 'lstep', 'CPpos', 'Yout', 'Ydes', 'xCoM', 'RMSEy', 'totEnergy')

    plotAllInfo
    
    figure(99)
    hold on
    plot(lstep)
    
end

%% Output based SMC-Extended

if(totSims >= 3)
    curSim  = 3;
    
    clearVectors
    t0 = 0;
    Q0   = [pi/2 - pi/10; pi/5; 2*pi-pi/10; pi+pi/10; -pi/4.5];
    dQ0  = zeros(5,1);
    ddQ0 = zeros(5,1);
    
    for curStep =1:numSteps
        disp('Starting the simulation step for SMCext')

        sim('OutputbasedSlidingmodeExtended.slx')

        Ut      = [Ut; Uc.signals.values];
        St      = [St; S.signals.values];
        Qt      = [Qt; Q.signals.values];
        dQt     = [dQt; dQ.signals.values];
        T       = [T; Q.time + t0];
        Tdisc   = [Tdisc; Uc.time + t0];

        t0 = t0 + Q.time(end);

        ti = [ti; t0];

        xstance = [xstance; ones(length(Q.signals.values(:,1)), 1)*xstance0];
        ystance = [ystance; ones(length(Q.signals.values(:,1)), 1)*ystance0];

        xstance0 = xstance0 + l1*cos(Qt(end,1)) + l2*cos(Qt(end,1) + Qt(end,2)) + l4*cos(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4)) + l5*cos(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4) + Qt(end,5));
        ystance0 = ystance0 + l1*sin(Qt(end,1)) + l2*sin(Qt(end,1) + Qt(end,2)) + l4*sin(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4)) + l5*sin(Qt(end,1) + Qt(end,2) + Qt(end,3) + Qt(end,4) + Qt(end,5));

        lstep = [lstep; (xstance0 - xstance(end))];
        CPpos = [CPpos; CP.signals.values];

        Yout  = [Yout; Y.signals.values];
        Ydes  = [Ydes; Yd.signals.values];

        xCoM  = [xCoM; XCoM.signals.values];

        totEnergy(3) = totEnergy(3) + Energy.signals.values(end);
        
        if(gait)
            [Qp, dQp, F2, pa_d, stoperror] = calcImpact(dQ.signals.values(end,:), Q.signals.values(end,:), gr, mr, Ir, cr, lr, mInc, D_e_imp, E_imp, varNames, floorfric, stoperror, curSim, curStep, checkStep);

            Q10 = Qp(1);
            Q20 = Qp(2);
            Q30 = Qp(3);
            Q40 = Qp(4);
            Q50 = Qp(5);

            dQ10 = dQp(1);
            dQ20 = dQp(2);
            dQ30 = dQp(3);
            dQ40 = dQp(4);
            dQ50 = dQp(5);

            Q0   = [Q10; Q20; Q30; Q40; Q50];
            dQ0  = [dQ10; dQ20; dQ30; dQ40; dQ50];

        end
        calcFreact;
        if((stoperror(curSim) == true) && (curStep >= checkStep))
            break;
        end
    end

    RMSEy = sqrt(sum((Yout - Ydes).^2)/length(Yout(:,1)));
    totRMSE = [totRMSE;RMSEy];
    
    mkdir(['Results/', cond, '/SMCext'])
    save(['Results/', cond, '/SMCext/Results.mat'], 'Ut', 'St', 'Qt', 'dQt', 'T', 'Tdisc', 'ti', 'xstance', 'ystance', 'lstep', 'CPpos', 'Yout', 'Ydes', 'xCoM', 'RMSEy', 'totEnergy')

    plotAllInfo
    
    figure(99)
    hold on
    plot(lstep)
    
end

figure(99)
legend('FL', 'SMC', 'SMCEX')

%% Save the results of the simulation
normalizeLimits

figure(1);
saveas(gcf, ['Results/', cond, '/', 'SlidingSurface'], 'png')

figure(2);
saveas(gcf, ['Results/', cond, '/', 'PositionTracking'], 'png')

figure(3);
saveas(gcf, ['Results/', cond, '/', 'VelocityTracking'], 'png')

figure(4);
saveas(gcf, ['Results/', cond, '/', 'ControlSignal'], 'png')

figure(5);
saveas(gcf, ['Results/', cond, '/', cond, 'OutputTracking'], 'png')

save(['Results/', cond, 'RMSE.mat'], 'totRMSE', 'totEnergy')
