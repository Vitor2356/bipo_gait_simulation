function [Qp, dQp, F2, pa_d, stoperror] = calcImpact(dQ, Q, gr, mr, Ir, cr, lr, mInc, D_e_imp, E_imp, varNames, floorfric, stoperror, curSim, curStep, checkStep)

    m1 = mr(1);
    m2 = mr(2);
    m3 = mr(3);
    m4 = mr(4);
    m5 = mr(5);
    
    I1 = Ir(1);
    I2 = Ir(2);
    I3 = Ir(3);
    I4 = Ir(4);
    I5 = Ir(5);
    
    c1 = cr(1);
    c2 = cr(2);
    c3 = cr(3);
    c4 = cr(4);
    c5 = cr(5);
    
    l1 = lr(1);
    l2 = lr(2);
    l3 = lr(3);
    l4 = lr(4);
    l5 = lr(5);
    
    q1 = Q(1);
    q2 = Q(2);
    q3 = Q(3);
    q4 = Q(4);
    q5 = Q(5);
    
    dq1 = dQ(1);
    dq2 = dQ(2);
    dq3 = dQ(3);
    dq4 = dQ(4);
    dq5 = dQ(5);
    
    
    % %%% Begin Calculations
    R=[1,1,1,1,1;0,0,0,0,-1;0,0,0,-1,0;0,0,-1,0,0;0,-1,0,0,0];

    p=[-3*pi;0;+3*pi;+3*pi;0];

    q_menos=[q1;q2;q3;q4;q5];
    q_d_menos=[dq1;dq2;dq3;dq4;dq5];

%     %%% Matrix De
    De = double(subs(D_e_imp, varNames, [gr; mr; Ir; lr; cr; zeros(30,1); Q'; dQ'; zeros(27,1)]));

%     %%% Matrix E2
    E2 = double(subs(E_imp, varNames, [gr; mr; Ir; lr; cr; zeros(30,1); Q'; dQ'; zeros(27,1)]));

    %%% Auxiliars
    De_inv=inv(De);

    del_f2=-(E2*De_inv*E2.')\E2*[eye(5);zeros(2,5)];
    del_qed_barra=De_inv*E2.'*del_f2+[eye(5);zeros(2,5)];

    F2=(del_f2*q_d_menos).';

    q_e_d_mais=del_qed_barra*q_d_menos;

    pa_d=q_e_d_mais(6:7).';             %Post Impact Swing Leg Velocity

    q_d_mais=q_e_d_mais(1:5);           %Post Impact Generalized Velocities

    q_mais=R*q_menos+p;                 %Post Impact Generalized Coordinates

    
    SWy = l1*sin(q_mais(1)) + l2*sin(q_mais(1) + q_mais(2)) + l4*sin(q_mais(1) + q_mais(2) + q_mais(3) + q_mais(4)) + l5*sin(q_mais(1) + q_mais(2) + q_mais(3) + q_mais(4) + q_mais(5));
    SWh = l1*cos(q_mais(1)) + l2*cos(q_mais(1) + q_mais(2)) + l4*cos(q_mais(1) + q_mais(2) + q_mais(3) + q_mais(4)) + l5*cos(q_mais(1) + q_mais(2) + q_mais(3) + q_mais(4) + q_mais(5));
    while(SWy <= SWh*mInc)
        q_mais=q_mais + [0;0;0;0;-0.001];   %Little Teek to Ensure that the Position of the Swing Feet Post Impact is Above Ground
        
        SWy = l1*sin(q_mais(1)) + l2*sin(q_mais(1) + q_mais(2)) + l4*sin(q_mais(1) + q_mais(2) + q_mais(3) + q_mais(4)) + l5*sin(q_mais(1) + q_mais(2) + q_mais(3) + q_mais(4) + q_mais(5));
        SWh = l1*cos(q_mais(1)) + l2*cos(q_mais(1) + q_mais(2)) + l4*cos(q_mais(1) + q_mais(2) + q_mais(3) + q_mais(4)) + l5*cos(q_mais(1) + q_mais(2) + q_mais(3) + q_mais(4) + q_mais(5));
    end

    Qp  = q_mais;
    dQp = q_d_mais;
    
    if(curStep >= checkStep)
        if(F2(2) < 0)
            disp('Robot pulls the floor');
            stoperror(curSim) = true;
        end
        if(F2(1) > floorfric*(m1+m2+m3+m4+m5)*gr)
            disp('Robot slips');
            stoperror(curSim) = true;
        end
    end
end