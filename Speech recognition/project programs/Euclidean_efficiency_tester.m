clc
clear all;
load newtestmatrix1.mat;
load newrefmat1.mat
 
 %newfilterbankarraydkk=[newfilterbankarraydkk zeros(1,50-length(newfilterbankarraydkk))];
x=importdata('newtestmatrix1.mat');
y=importdata('newrefmat1.mat');
 for i=1:100
    output(i) = sqrt(sum((x(i,:)-y(i,:)).^2));
end

[~,index] = min(output);
disp(floor((index-1)/10));