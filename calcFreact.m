%% Auxiliary Accelerations

for i = 1:length(Q.time)

    % Get the variables
    q1 = Q.signals.values(i,1);
    q2 = Q.signals.values(i,2);
    q3 = Q.signals.values(i,3);
    q4 = Q.signals.values(i,4);
    q5 = Q.signals.values(i,5);

    dq1 = dQ.signals.values(i,1);
    dq2 = dQ.signals.values(i,2);
    dq3 = dQ.signals.values(i,3);
    dq4 = dQ.signals.values(i,4);
    dq5 = dQ.signals.values(i,5);

    ddq1 = ddQ.signals.values(i,1);
    ddq2 = ddQ.signals.values(i,2);
    ddq3 = ddQ.signals.values(i,3);
    ddq4 = ddQ.signals.values(i,4);
    ddq5 = ddQ.signals.values(i,5);

    
    ddO = [0,0];

    ddA  = ddO +                (ddq1)*l1*[-sin(q1), cos(q1)]                   +             (dq1)^2*l1*[-cos(q1), -sin(q1)];
    ddB  = ddA +           (ddq1+ddq2)*l2*[-sin(q1+q2), cos(q1+q2)]             +         (dq1+dq2)^2*l2*[-cos(q1+q2), -sin(q1+q2)];
    ddC  = ddB + (ddq1+ddq2+ddq3+ddq4)*l4*[-sin(q1+q2+q3+q4), cos(q1+q2+q3+q4)] + (dq1+dq2+dq3+dq4)^2*l4*[-cos(q1+q2+q3+q4), -sin(q1+q2+q3+q4)];

    myAc1 = ddO +                     (ddq1)*(l1-c1)*[-sin(q1), cos(q1)]                    +                 (dq1)^2*(l1-c1)*[-cos(q1), -sin(q1)];
    myAc2 = ddA +                (ddq1+ddq2)*(l2-c2)*[-sin(q1+q2), cos(q1+q2)]              +             (dq1+dq2)^2*(l2-c2)*[-cos(q1+q2), -sin(q1+q2)];
    myAc3 = ddB +           (ddq1+ddq2+ddq3)*c3*[-sin(q1+q2+q3), cos(q1+q2+q3)]             +         (dq1+dq2+dq3)^2*c3*[-cos(q1+q2+q3), -sin(q1+q2+q3)];
    myAc4 = ddB +      (ddq1+ddq2+ddq3+ddq4)*c4*[-sin(q1+q2+q3+q4), cos(q1+q2+q3+q4)]       +     (dq1+dq2+dq3+dq4)^2*c4*[-cos(q1+q2+q3+q4), -sin(q1+q2+q3+q4)];
    myAc5 = ddC + (ddq1+ddq2+ddq3+ddq4+ddq5)*c5*[-sin(q1+q2+q3+q4+q5), cos(q1+q2+q3+q4+q5)] + (dq1+dq2+dq3+dq4+dq5)^2*c5*[-cos(q1+q2+q3+q4+q5), -sin(q1+q2+q3+q4+q5)];

    ddCoM = (m1*myAc1 + m2*myAc2 + m3*myAc3 + m4*myAc4 + m5*myAc5)/(m1 + m2 + m3 + m4 + m5);

    %% Checks for slipage and pulling the ground
    if((m1+m2+m3+m4+m5)*g - ddCoM(2) < 0) 
        disp('Robot pulls the ground!');
        stoperror(curSim) = true;
        break;
    end
    
    if(ismember(curStep, pertStep))
        if(Q.time(i) <= pertDur)
            if(ddCoM(1) + pertAmp > floorfric*(m1+m2+m3+m4+m5)*g)
                disp('Robot slips!');
                stoperror(curSim) = true;
                break;
            end
        else
            if(ddCoM(1) > floorfric*(m1+m2+m3+m4+m5)*g)
                disp('Robot slips!');
                stoperror(curSim) = true;
                break;
            end
        end
    else
        if(ddCoM(1) > floorfric*(m1+m2+m3+m4+m5)*g)
            disp('Robot slips!');
            stoperror(curSim) = true;
            break;
        end
    end
end   
 