clear;
clc;

for i=0:9
    data = [];
    for j=0:9
        load(sprintf('%d_sample_%d.mat',i,j));
        data = [data ;[newfilterbankarraydkk]];
    end
    average_data(i,:) =(mean(data,1));
end