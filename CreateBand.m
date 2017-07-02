function points = CreateBand(P1,P2,npoints)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
d=(P2-P1)/(npoints-1);
points=zeros(3,npoints);
points(:,1)=P1;
for i=2:npoints
    points(:,i)=points(:,i-1)+d;
end
end

