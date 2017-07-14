function [Points disp] = grad(Points,Neighbours,Force,L,k1,Param)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
d1=size(Points,1);
MaxIter = 200;
prec=1e-8;
counter=1;
alpha = 1;
Points_sc=zeros(d1*3,1);
D=zeros(d1*3,1);
disp=zeros(1,MaxIter);
for i=1:d1
        Points_sc((i-1)*3+1:(i-1)*3+3,1)=Points(i,:)';   
end
while (counter<=MaxIter)
    for i=5:d1        
        D((i-1)*3+1:(i-1)*3+3,1) = GradientCalc3(Points_sc,i,Neighbours,Force,L,k1,Param);   
    end
    disp(counter)=sqrt(sum((alpha*D).^2)/length(D));
    Points_sc=Points_sc+alpha*D;
    display(counter);
    counter=counter+1;
end
for i=5:d1
        Points(i,:)=Points_sc((i-1)*3+1:(i-1)*3+3,1)';   
end
end