function M= point2line(A,P1,P2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
a=(P2-P1);
t=sum(a.*(A-P1))/sum(a.^2);
M=P1+a*t;

end

