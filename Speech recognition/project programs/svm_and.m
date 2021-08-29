clc;
clear all;
%%%%%%%%AND GATE%%%%%%%%%
x=[0 0;0 1;1 0;1 1];
y=[0;0;0;1];
svm_struct = svmtrain(x,y);
out = svmclassify(svm_struct,x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%OR GATE%%%%%%%%%%
x1=[0 0;0 1;1 0;1 1];
y1=[0;1;1;1];
svm_struct1 = svmtrain(x1,y1);
out1 = svmclassify(svm_struct1,x1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%NAND GATE%%%%%%%%%%%%%
x2=[0 0;0 1;1 0;1 1];
y2=[1;1;1;0];
svm_struct2 = svmtrain(x2,y2);
out2 = svmclassify(svm_struct2,x2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%N0R GATE%%%%%%%%%%%%
x3=[0 0;0 1;1 0;1 1];
y3=[1;0;0;0];
svm_struct3 = svmtrain(x3,y3);
out3 = svmclassify(svm_struct3,x3);
%%%%%%%%%%%%%%%%%EX-OR%%%%%%%%%%%%%%%%%%%%%%%%%%%
x4=[0 0;0 1;1 0;1 1];
y4=[0;1;1;0];
svm_struct4 = svmtrain(x4,y4,'kernel_function','rbf');
out4 = svmclassify(svm_struct4,x4);
