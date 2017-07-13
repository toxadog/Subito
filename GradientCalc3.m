function Grad = GradientCalc3(Points,Pos,N,Force,L,k0,Param)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
Grad=zeros(3,1);
dp=0.01e-3;
pos0=find(N(Pos,:)==0);
if isempty(pos0)
    NNeig=15;
else
    NNeig=pos0(1)-1;
end
if NNeig~=0
Neighbours=zeros(NNeig,3);

for counter = 1:NNeig
    PosN=N(Pos,counter);
    Neighbours(counter,:)=Points((PosN-1)*3+1:(PosN-1)*3+3,1)';        
end
P = Points((Pos-1)*3+1:(Pos-1)*3+3,1)';
Pnew1= ones(3,3)*diag(P)+diag(ones(1,3)*(dp));
Pnew2= ones(3,3)*diag(P)-diag(ones(1,3)*(dp));
D0=sqrt(sum((Neighbours-ones(NNeig,3)*diag(P)).^2,2))-L(Pos,1:NNeig)';
for k=1:3
    D1=sqrt(sum((Neighbours-ones(NNeig,3)*diag(Pnew1(k,:))).^2,2))-L(Pos,1:NNeig)';
    D1=D1(D1>0);
    if isempty(D1)
        D1=0;
    end
    D2=sqrt(sum((Neighbours-ones(NNeig,3)*diag(Pnew2(k,:))).^2,2))-L(Pos,1:NNeig)';
    D2=D2(D2>0);
    if isempty(D2)
        D2=0;
    end
    Pen1 = penalty(Pnew1(k,:)',Param);
    Pen2 = penalty(Pnew2(k,:)',Param);
    E1=sum(((D1/1000).^2)*k0/2)-Force(Pos,k)*dp/1000+(Pen1/1000)^2*k0/2;
    E2=sum(((D2/1000).^2)*k0/2)+Force(Pos,k)*dp/1000+(Pen2/1000)^2*k0/2;
    Grad(k)=-(E1-E2)/(2*dp);
end
% Grad=round(Grad*1e6)/1e6;
end

end

