clc
clear all;
testmatrix1=zeros(100,50);
for i=0:9
  for  j=0:9
      load(sprintf('%d_sample_%d.mat',i,j));
      testmatrix1(10*i+j+1,:)=[newfilterbankarraydkk zeros(1,50-length(newfilterbankarraydkk))];
  end
end

   save('testmatrix1','testmatrix1');
  