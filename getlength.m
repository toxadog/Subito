function L = getlength(Param)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
nL=7;
bonepoints = Param.currentbonepoints;
hand = Param.hand;
R1=hand(9);
R2=hand(10);
R3=hand(11);
r1=hand(5);
r2=hand(6);
r3=hand(7);
r4=hand(8);
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
P=[P1 C1 P2 C2 C3 P3 C4 C5 P4 C6 P5];
R=[r4;R3;r3;R2;r2;R1;r1];
MCP=getangleSigned(P3-P2,P2-P1);
PIP=getangleSigned(P4-P3,P3-P2);
DIP=getangleSigned(P5-P4,P4-P3);
alphamin=[0;asin(r4/R3);0;asin(r3/R2);0;asin(r2/R1);0]; 
alphamax=[0;MCP+pi-asin(r3/R3);0;PIP+pi-asin(r2/R2);0;DIP+pi-asin(r1/R1);0]; 
L=zeros(nL,1);
for i=1:nL
    if mod(i,2)
        L(i)=modulus(P(:,1+round((i-1)*3/2))-P(:,1+round((i-1)*3/2)+1));
    else
        L(i)=(alphamax(i)-alphamin(i))*R(i);
    end
end
end
