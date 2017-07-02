function Pnew = createPointLong(P,dl, Param)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sL=getlength(Param);
bonepoints = Param.currentbonepoints;
P1=bonepoints(:,1);
P2=bonepoints(:,2);
P3=bonepoints(:,3);
P4=bonepoints(:,4);
P5=bonepoints(:,5);
C1=bonepoints(:,6);
C2=bonepoints(:,7);
C3=bonepoints(:,8);
C4=bonepoints(:,9);
C5=bonepoints(:,10);
C6=bonepoints(:,11);
hand = Param.hand;
R1=hand(9);
R2=hand(10);
R3=hand(11);
r1=hand(5);
r2=hand(6);
r3=hand(7);
r4=hand(8);
R=[r4;R3;r3;R2;r2;R1;r1];
alphamin=[0;asin(r4/R3);0;asin(r3/R2);0;asin(r2/R1);0]; 
lmin=[0;0;modulus(C2-P2);0;modulus(C4-P3);0;modulus(C6-P4)];
n=P(3);
if mod(n,2)
    l=P(2)-lmin(n);
    angTrans=P(1);
else
    l=(P(1)-alphamin(n))*R(n);
    angTrans=P(2);
end
[lnew,nnew]=calcL(dl,l,n,sL);

if mod(nnew,2)
    Pnew=[angTrans,lnew+lmin(nnew),nnew];
else
    Pnew=[alphamin(nnew)+lnew/R(nnew),angTrans,nnew];
end

end

