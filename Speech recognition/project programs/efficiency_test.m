clear;clc;
count=0;
load newrefmat1.mat; 
load newtestmatrix1.mat;
for i=1:100
 for j=1:100  
output(j) = sqrt(sum((newtestmatrix1(i,:)-newrefmat1(j,:)).^2));
 end
[~,index] = min(output);
if(floor((index-1)/10)==floor((i-1)/10))
      count=count+1;
end
disp(floor((index-1)/10));

end



