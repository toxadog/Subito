function angle = TendonAngle(Tendons,AngNumb)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
O2=Tendons.t6(1:3,1);
A=Tendons.t2r(1:3,1);
Br=Tendons.t5r(1:3,1);
C=Tendons.t8(1:3,1);
Er=Tendons.t13r(1:3,1);
F=Tendons.t10r(1:3,1);
J=Tendons.t11r(1:3,1);
Kr=Tendons.t11r(1:3,size(Tendons.t11r,2));
switch AngNumb
    case 1
        EK=Er-Kr;
        JK=J-Kr;
        angle=getangle(EK,JK);
    case 2
        BE=Br-Er;
        FE=F-Er;
        angle=getangle(BE,FE);
    case 3
        CJ=C-J;
        BJ=Br-J;
        angle=getangle(CJ,BJ);
    case 4
        CE=C-Er;
        BE=Br-Er;
        angle=getangle(CE,BE);
    case 5
        EB=Er-Br;
        O2B=O2-Br;
        angle=getangle(EB,O2B);
    case 6
        O2B=O2-Br;
        AB=A-Br;
        angle=getangle(O2B,AB);
    otherwise
        display('Angle number is incorrect');
        angle=0;
end
        

end

