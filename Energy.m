function f = Energy(dP,P,points,Param,coef,l0,MuscleForce,pen)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
M = Param.M;
PulleyR = Param.PulleyR;
hand = Param.hand;
currentbonepoints = Param.currentbonepoints;
PulleyM1=M(:,5);
PulleyM3=M(:,6);
PulleyM4=M(:,7);
R2=hand(10);
PulleyM5u=currentbonepoints(:,3)+[R2;0;0];
PulleyM5r=currentbonepoints(:,3)+[-R2;0;0];
npoints=size(points,2);
    switch pen
        case 100
            penx=abs(P(1)+dP(1)); 
        case 20
            PulleyM1YOZ=[0; PulleyM1(2); PulleyM1(3)];
            Ppr=point2line((dP+P),PulleyM1,PulleyM1YOZ);
            if (modulus((dP+P)-Ppr)<PulleyR)
                penx=PulleyR-modulus(dP+P-Ppr);
            else
                penx=0;
            end
        case 21
            PulleyM3YOZ=[0; PulleyM3(2); PulleyM3(3)];
            Ppr=point2line((dP+P),PulleyM3,PulleyM3YOZ);
            if (modulus((dP+P)-Ppr)<PulleyR)
                penx=PulleyR-modulus(dP+P-Ppr);
            else
                penx=0;
            end
        case 22
            penx=abs(P(1)+dP(1));   
        case 25
            PulleyM1YOZ=[0; PulleyM1(2); PulleyM1(3)];
            Ppr=point2line((dP+P),PulleyM1,PulleyM1YOZ);
            if (modulus((dP+P)-Ppr)<PulleyR)
                penx=PulleyR-modulus(dP+P-Ppr);
            else
                penx=0;
            end
        case 26
            PulleyM3YOZ=[0; PulleyM3(2); PulleyM3(3)];
            Ppr=point2line((dP+P),PulleyM3,PulleyM3YOZ);
            if (modulus((dP+P)-Ppr)<PulleyR)
                penx=PulleyR-modulus(dP+P-Ppr);
            else
                penx=0;
            end
        case 6
            PulleyM5uYOZ=[0; PulleyM5u(2); PulleyM5u(3)];
            Ppr=point2line((dP+P),PulleyM5u,PulleyM5uYOZ);
            if (modulus((dP+P)-Ppr)<PulleyR)
                penx=PulleyR-modulus(dP+P-Ppr);
            else
                penx=0;
            end
        case 7
            PulleyM5rYOZ=[0; PulleyM5r(2); PulleyM5r(3)];
            Ppr=point2line((dP+P),PulleyM5r,PulleyM5rYOZ);
            if (modulus((dP+P)-Ppr)<PulleyR)
                penx=PulleyR-modulus(dP+P-Ppr);
            else
                penx=0;
            end
        case 8
            PulleyM5uYOZ=[0; PulleyM5u(2); PulleyM5u(3)];
            Ppr=point2line((dP+P),PulleyM5u,PulleyM5uYOZ);
            if (modulus((dP+P)-Ppr)<PulleyR)
                penx=PulleyR-modulus(dP+P-Ppr);
            else
                penx=0;
            end
        case 9
            PulleyM5rYOZ=[0; PulleyM5r(2); PulleyM5r(3)];
            Ppr=point2line((dP+P),PulleyM5r,PulleyM5rYOZ);
            if (modulus((dP+P)-Ppr)<PulleyR)
                penx=PulleyR-modulus(dP+P-Ppr);
            else
                penx=0;
            end
        case 27
            PulleyM4YOZ=[0; PulleyM4(2); PulleyM4(3)];
            Ppr=point2line((dP+P),PulleyM4,PulleyM4YOZ);
            if (modulus((dP+P)-Ppr)<PulleyR)
                penx=PulleyR-modulus(dP+P-Ppr);
            else
                penx=0;
            end
        otherwise
        penx=0;
    end
    
    sigma=0.04;
%     sigma=0;
    X=0;

    for i=1:npoints        
        X=X+(coef(i)*(1e-3*(modulus(points(:,i)-(P+dP))-l0(i)))^2)/2;        
    end 
    f=X-1e-3*MuscleForce'*dP+sigma*penalty(dP+P,Param)^2+sigma*penx^2;
    
end

