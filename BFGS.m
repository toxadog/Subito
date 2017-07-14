function [Points disp] = BFGS(Points,Neighbours,Force,L,k1,Param)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
d1=size(Points,1);
MaxIter = 50;
prec=1e-8;
counter=1;
alpha = 0.5;
Points_sc=zeros(d1*3,1);
D=zeros(d1*3,1);
disp=zeros(1,MaxIter);
for i=1:d1
        Points_sc((i-1)*3+1:(i-1)*3+3,1)=Points(i,:)';   
end
while (counter<=MaxIter)
    if counter == 1
        for i=1:d1        
                D((i-1)*3+1:(i-1)*3+3,1) = GradientCalc3(Points_sc,i,Neighbours,Force,L,k1,Param);   
        end
        C=0.001*eye(d1*3);
    end
    Points_sc=Points_sc+alpha*C*D;
    S=alpha*C*D;
    disp(counter)=sqrt(sum(S.^2)/length(S));
    Dold=D;
    for i=1:d1
         D((i-1)*3+1:(i-1)*3+3,1) = GradientCalc3(Points_sc,i,Neighbours,Force,L,k1,Param);
    end
    y=-(D-Dold);
%     if (S'*S)~=0
        dC=((S'*y+y'*C*y)*(S*S')/(S'*y)^2-(C*y*S'+S*y'*C)/(S'*y));
        dC=round(dC*1e6)/1e6;
        C=C+1*(dC);
%     end
    display(counter);
    counter=counter+1;


end
for i=1:d1
        Points(i,:)=Points_sc((i-1)*3+1:(i-1)*3+3,1)';   
end
end