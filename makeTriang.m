function Triang = makeTriang(A,B,C,Param)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
L = Param.L;
pointsdens = Param.pointsdens;

L1=CreateBand(A,B,round(L(14)*pointsdens));
n=size(L1,2);
for i=1:n
       Triang(:,:,i)=CreateBand(L1(:,i),C,round(L(3)*pointsdens));
end

end

