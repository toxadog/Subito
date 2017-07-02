function Pnew = createPointTrans(P,dl, Param)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
hand = Param.hand;
R1=hand(9);
R2=hand(10);
R3=hand(11);
r1=hand(5);
r2=hand(6);
r3=hand(7);
r4=hand(8);
R=[r4;R3;r3;R2;r2;R1;r1];
n=P(3);
if mod(n,2)
    Pnew=[P(1)+dl/R(n),P(2),n];
else
    Pnew=[P(1),P(2)+dl/R(n),n];
end

end

