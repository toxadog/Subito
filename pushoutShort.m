function Pnew = pushoutShort(P,Param)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
bonepoints = Param.currentbonepoints;
hand = Param.hand;
l3=hand(3);
l4=hand(4);
r3=hand(7);
r4=hand(8);

R2=hand(10);
R3=hand(11);
P1=bonepoints(:,1);
P2=bonepoints(:,2);
P3=bonepoints(:,3);

C1=bonepoints(:,6);
C2=bonepoints(:,7);
C3=bonepoints(:,8);

Q1=(P1+P2)/2;
Q2=(P2+P3)/2;


 
if (modulus(P-Q1)<sqrt(l4^2/4+r4^2))&&(modulus(P-P2)>=R3)&&(modulus(P-Q2)>=sqrt(l3^2/4+r3^2))
    Pr1=point2line(P,P1,P2);
    if ((P1-Pr1)'*(C1-Pr1)<0)&&(modulus(P-Pr1)<r4)
        Pnew=Pr1+r4.*(P-Pr1)./modulus(P-Pr1);     
    else
        Pnew=P;
    end
else if (modulus(P-Q2)<sqrt(l3^2/4+r3^2))&&(modulus(P-P3)>=R2)&&(modulus(P-P2)>=R3)&&(modulus(P-Q1)>=sqrt(l4^2/4+r4^2))
        Pr2=point2line(P,P2,P3);
        if ((C2-Pr2)'*(C3-Pr2)<0)&&(modulus(P-Pr2)<r3)
            Pnew=Pr2+r3.*(P-Pr2)./modulus(P-Pr2);
        else
            Pnew=P;
        end
    else if modulus(P-P2)<R3
            Pr1=point2line(P,P1,P2);
                    if ((C1-Pr1)'*(P2-Pr1)<0)&&(modulus(P-Pr1)<modulus(Pr1-P2)*r4/modulus(P2-C1)) 
                        Pnew=C1+r4.*(P-Pr1)./modulus(P-Pr1); 
                    else
                        Pr2=point2line(P,P2,P3);
                        if ((P2-Pr2)'*(C2-Pr2)<0)&&(modulus(P-Pr2)<modulus(Pr2-P2)*r3/modulus(P2-C2))
                            Pnew=C2+r3.*(P-Pr2)./modulus(P-Pr2);                          
                        else if ((C2-Pr2)'*(C3-Pr2)<0)&&(modulus(P-Pr2)<r3)
                                Pnew=Pr2+r3.*(P-Pr2)./modulus(P-Pr2);
                            else if ((P1-Pr1)'*(C1-Pr1)<0)&&(modulus(P-Pr1)<r4)
                                    Pnew=Pr1+r4.*(P-Pr1)./modulus(P-Pr1);
                                else
                            Pnew=P2+R3.*(P-P2)./modulus(P-P2);
                                end
                            end
                        end
                    end
        else if (modulus(P-Q1)<sqrt(l4^2/4+r4^2))&&(modulus(P-Q2)<sqrt(l3^2/4+r3^2))
                Pr1=point2line(P,P1,P2);
                if ((P1-Pr1)'*(C1-Pr1)<0)&&(modulus(P-Pr1)<r4)
                    Pnew=Pr1+r4.*(P-Pr1)./modulus(P-Pr1);         
                else
                    Pr2=point2line(P,P2,P3);
                    if ((C2-Pr2)'*(C3-Pr2)<0)&&(modulus(P-Pr2)<r3)
                        Pnew=Pr2+r3.*(P-Pr2)./modulus(P-Pr2);
                    else
                        Pnew=P;
                    end
                end
            else
                Pnew=P;
            end
        end
    end
end
end
          




    

               

                                                        
    



