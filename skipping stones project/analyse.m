clc
clear all;
% A=[10 7 8 7;7 5 6 5;8 6 10 9;7 5 9 10];
% B=[32 23 33 31];
% x=inv(A)*B'
% AA=[10 7 8.1 7.2;7.08 5.04 6 5;8 5.98 9.89 9;6.99 4.99 9 9.98];
% xx=inv(AA)*B'
% norm(A,1)*norm(inv(A),1)
 
A=[0.0003 3;1 1];
B=[3 3];
x=inv(A)*B'
AA=[0.0003 3.1; 1 1];
xx=inv(AA)*B'
norm(A,1)*norm(inv(A),1)