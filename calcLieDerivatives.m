%Calc Lie Derivatives
syms   q1   q2   q3   q4   q5
syms  dq1  dq2  dq3  dq4  dq5
syms ddq1 ddq2 ddq3 ddq4 ddq5

assume([  q1,   q2,   q3,   q4,   q5], 'real');
assume([ dq1,  dq2,  dq3,  dq4,  dq5], 'real');
assume([ddq1, ddq2, ddq3, ddq4, ddq5], 'real')

syms l1 l2 l3 l4 l5
syms c1 c2 c3 c4 c5
syms m1 m2 m3 m4 m5

assume([l1, l2, l3, l4, l5], 'real');
assume([c1, c2, c3, c4, c5], 'real');
assume([m1, m2, m3, m4, m5], 'real');

qvec   = [  q1;   q2;   q3;   q4;   q5];
dqvec  = [ dq1;  dq2;  dq3;  dq4;  dq5];
ddqvec = [ddq1; ddq2; ddq3; ddq4; ddq5];

O = [0, 0];

A  = O + l1*[cos(q1), sin(q1)];
B  = A + l2*[cos(q1+q2), sin(q1+q2)];
C  = B + l4*[cos(q1+q2+q3+q4), sin(q1+q2+q3+q4)];

P1 = O + (l1-c1)*[cos(q1), sin(q1)];
P2 = A + (l2-c2)*[cos(q1+q2), sin(q1+q2)];
P3 = B + c3*[cos(q1+q2+q3), sin(q1+q2+q3)];
P4 = B + c4*[cos(q1+q2+q3+q4), sin(q1+q2+q3+q4)];
P5 = C + c5*[cos(q1+q2+q3+q4+q5), sin(q1+q2+q3+q4+q5)];

Qt = (5*pi/2) - q1 - q2 - q3;
Swx = l1*cos(q1) + l2*cos(q1+q2) + l4*cos(q1+q2+q3+q4) + l5*cos(q1+q2+q3+q4+q5);
Swy = l1*sin(q1) + l2*sin(q1+q2) + l4*sin(q1+q2+q3+q4) + l5*sin(q1+q2+q3+q4+q5);
CoM = (m1*P1 + m2*P2 + m3*P3 + m4*P4 + m5*P5)/(m1+m2+m3+m4+m5);

CoMx = CoM(1);
CoMy = CoM(2);

% Ybar = [Qt; Swy; CoMy; Swx; 2*CoMx - Swx];
Ybar = [Qt; Swy; CoMy; Swx];

f1 = dqvec;
f2 = ddqvec;

diffCq_q   = simplify(jacobian(Ybar, qvec));
diffCq_dq  = simplify(jacobian(Ybar, dqvec));
diffCq_ddq = simplify(jacobian(Ybar, ddqvec));

LfCq = diffCq_q*f1;

diffLfCq_q   = simplify(jacobian(LfCq, qvec));
diffLfCq_dq  = simplify(jacobian(LfCq, dqvec));
diffLfCq_ddq = simplify(jacobian(LfCq, ddqvec));

Lf_2_Cq  = diffLfCq_q*f1 + diffLfCq_dq*f2;

diffLf_2_Cq_q   = simplify(jacobian(Lf_2_Cq, qvec));
diffLf_2_Cq_dq  = simplify(jacobian(Lf_2_Cq, dqvec));
diffLf_2_Cq_ddq = simplify(jacobian(Lf_2_Cq, ddqvec));

cd('Auxiliar')

exportToTxt(diffCq_q,        'diffCq_q')
exportToTxt(diffLfCq_q,      'diffLfCq_q')
exportToTxt(diffLfCq_dq,     'diffLfCq_dq')
exportToTxt(diffLf_2_Cq_q,   'diffLf_2_Cq_q')
exportToTxt(diffLf_2_Cq_dq,  'diffLf_2_Cq_dq')
exportToTxt(diffLf_2_Cq_ddq, 'diffLf_2_Cq_ddq')

cd('..')