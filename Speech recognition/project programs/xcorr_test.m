clear;clc;
count=0;
load average_data.mat;

for no=0:9;
for sample=1;

load(sprintf('%d_sample_%d.mat',no,sample));
a=[a;zeros(100-size(a,1),2)];

for i=0:9
   
    output(i+1) = max(xcorr(a(:,2),average_data(:,i+1)));
    output2(i+1) = sqrt(sum((a(:,2)-average_data(:,i+1)).^2));
    
end

[~,index] = min(output2);

disp(index-1);
if index-1 == no
    count=count+1;
end

end
end

% efficiency = count/50;
% disp(efficiency);