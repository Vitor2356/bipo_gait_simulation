%Estou calculando as acelerações dos centros de massa para calcular as
%forças no pé de apoio do robo durante a marcha.
close all
clc

disp('Starting the Preparations')
disp(datetime('now'))

syms m1 m2 m3 m4 m5
syms I1 I2 I3 I4 I5
syms g

assume([m1, m2, m3, m4, m5], 'positive');
assume([I1, I2, I3, I4, I5], 'positive');
assume(g, 'positive');

syms l1 l2 l3 l4 l5
syms c1 c2 c3 c4 c5

assume([l1, l2, l3, l4, l5], 'positive');
assume([c1, c2, c3, c4, c5], 'positive');

syms   q1   q2   q3   q4   q5
syms  dq1  dq2  dq3  dq4  dq5
syms ddq1 ddq2 ddq3 ddq4 ddq5

assume([q1, q2, q3, q4, q5], 'real');
assume([dq1, dq2, dq3, dq4, dq5], 'real');
assume([ddq1, ddq2, ddq3, ddq4, ddq5], 'real');

p1 = 