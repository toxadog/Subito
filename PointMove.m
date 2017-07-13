function [Points, D, D2] = PointMove(Points,Neighbours,Force,Param,L)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
NPoints=size(Points,1);
PointsNew=Points;
MaxIter = 5;
prec=1e-8;
counter=1;
% alpha = 0.0005;
% alpha = 0.00025;
% alpha = 1;
alpha = 0.02;
D=zeros(1,MaxIter);
D2=[];
while (counter<=MaxIter)
    Points2=Points+alpha*zeros(size(Force));
    [PointsNew d2]= constr(Points2,Neighbours,Param,L);
    D2=[D2; d2];
    depl=sqrt(sum((Points-PointsNew).^2,2));
    D(counter)=mean(depl(~isnan(depl)));
    Points(5:NPoints,:)=PointsNew(5:NPoints,:);
    display(counter);
    counter=counter+1;
end
end
