function Quad = makeQuad(A,B,C,D,Param)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
L = Param.L;
pointsdens = Param.pointsdens;

L1=CreateBand(A,B,round(L(17)*pointsdens));
L2=CreateBand(D,C,round(L(17)*pointsdens));
n=size(L1,2);
for i=1:n
       Quad(:,:,i)=CreateBand(L1(:,i),L2(:,i),round(L(19)*pointsdens));
end

end

