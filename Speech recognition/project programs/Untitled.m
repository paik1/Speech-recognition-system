clc;
clear all;
load cat.mat;
load rat.mat;
load bat.mat;
plot(newfilterbankarraydkk(1,1:36),'r','DisplayName','sample1','YDataSource','newfilterbankarraydkk(1,1:36)'); hold on;
xlabel('Number of Frames');ylabel('FILTER BANK');
plot(newfilterbankarraydkk1(1,1:38),'g','DisplayName','sample2','YDataSource','newfilterbankarraydkk1(1,1:31)');hold on;
xlabel('Number of Frames');ylabel('FILTER BANK');
plot(newfilterbankarraydkk2(1,1:32),'b','DisplayName','sample3','YDataSource','newfilterbankarraydkk2(1,1:31)');hold on;
xlabel('Number of Frames');ylabel('FILTER BANK');
title('DIGIT ZERO PLOT')