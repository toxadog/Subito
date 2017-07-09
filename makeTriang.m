function Triang = makeTriang(A,B,C,npoints1,npoints2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
L1=CreateBand(A,B,npoints1);
n=size(L1,2);
for i=1:n
       Triang(:,:,i)=CreateBand(L1(:,i),C,npoints2);
end

end

