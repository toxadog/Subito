function Point = local2cart(pointloc,DIP,PIP,MCP,Param)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
hand = Param.hand;
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
coordnum=pointloc(3);
if (coordnum==2)||(coordnum==4)||(coordnum==6)
    ang1=pointloc(1);
    ang2=pointloc(2);
else
    alf=pointloc(1);
    z=pointloc(2);
end
switch coordnum 
    case 1
        r=r4;
        Point=[r*sin(alf);r*cos(alf);z];
    case 2
        r=R3;
        Point=[r*sin(ang2);r*cos(ang2)*cos(ang1-pi/2);r*cos(ang2)*sin(ang1-pi/2)]+[0;0;l4];
    case 3
        r=r3;
        Point=ROTx3(MCP)*[r*sin(alf);r*cos(alf);z]+[0;0;l4];
    case 4
        r=R2;
        Point=ROTx3(MCP)*([r*sin(ang2);r*cos(ang2)*cos(ang1-pi/2);r*cos(ang2)*sin(ang1-pi/2)]+[0;0;l3])+[0;0;l4];        
    case 5
        r=r2;
        Point=ROTx3(MCP)*(ROTx3(PIP)*[r*sin(alf);r*cos(alf);z]+[0;0;l3])+[0;0;l4];
    case 6
        r=R1;
        Point=ROTx3(MCP)*(ROTx3(PIP)*([r*sin(ang2);r*cos(ang2)*cos(ang1-pi/2);r*cos(ang2)*sin(ang1-pi/2)]+[0;0;l2])+[0;0;l3])+[0;0;l4];        
    case 7
        r=r1;
        Point=ROTx3(MCP)*(ROTx3(PIP)*(ROTx3(DIP)*[r*sin(alf);r*cos(alf);z]+[0;0;l2])+[0;0;l3])+[0;0;l4];
end
       
end

