clc;
clear all;
load newrefmat1.mat;
load newtestmatrix1.mat;
x=importdata('newrefmat1.mat');
y=importdata('newrefmat1.mat');
testing=[];
testing=[x;y];
save('testing','testing');