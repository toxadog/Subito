function Quad = makeQuad(A,B,C,D,npoints1,npoints2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

L1=CreateBand(A,B,npoints1);
L2=CreateBand(D,C,npoints1);
n=size(L1,2);
for i=1:n
       Quad(:,:,i)=CreateBand(L1(:,i),L2(:,i),npoints2);
end

end

