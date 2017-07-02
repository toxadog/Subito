function points = BonesConf(DIP,PIP,MCP,Param)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
hand = Param.hand;
l1=hand(1);
l2=hand(2);
l3=hand(3);
l4=hand(4);
r1=hand(5);
r2=hand(6);
r3=hand(7);
r4=hand(8);
R1=hand(9);
R2=hand(10);
R3=hand(11);
P1=[0; 0; 0];
P2=[0; 0; l4];

C1=[0; 0; l4-sqrt(R3^2-r4^2)];

C2=P2+ROTx3(MCP)*[0;0;sqrt(R3^2-r3^2)];
C3=P2+ROTx3(MCP)*[0;0;l3-sqrt(R2^2-r3^2)];
P3=P2+ROTx3(MCP)*[0;0;l3];
C4=P3+ROTx3(PIP+MCP)*[0; 0;sqrt(R2^2-r2^2)];
C5=P3+ROTx3(PIP+MCP)*[0; 0;l2-sqrt(R1^2-r2^2)];
P4=P3+ROTx3(PIP+MCP)*[0;0;l2];
C6=P4+ROTx3(DIP+PIP+MCP)*[0;0;sqrt(R1^2-r1^2)];
P5=P4+ROTx3(DIP+PIP+MCP)*[0;0;l1];
points=[P1 P2 P3 P4 P5 C1 C2 C3 C4 C5 C6];

end

