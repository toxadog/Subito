function Points = PointMove(Points,Neighbours,Force,Param)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
NPoints=size(Points,1);
PointsNew=Points;
MaxIter = 20;
prec=1e-8;
counter=1;
% alpha = 0.0005;
% alpha = 0.00025;
% alpha = 1;
alpha = 0.02;
while (counter<=MaxIter)
    Points2=Points+alpha*Force;
    PointsNew= constr(Points2,Neighbours,Param);
    Points(5:NPoints,:)=PointsNew(5:NPoints,:);
    counter=counter+1;
    display(counter);
end
