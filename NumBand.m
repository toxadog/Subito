function points = NumBand(P1,P2,npoints,point1)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
points=zeros(1,npoints);
points(1)=P1;
points(npoints)=P2;
for i=2:npoints-1
    points(i)=point1+i-2;
end
end

