clc
clear all;
testmatrix2=zeros(100,50);
for i=0:9
  for  j=0:9
      load(sprintf('%d_dsample_%d.mat',i,j));
      testmatrix2(10*i+j+1,:)=[newfilterbankarraydkk zeros(1,50-length(newfilterbankarraydkk))];
  end
end

   save('testmatrix2','testmatrix2');
  