function [Pnew, Flag] = pushout(P,Param)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
bonepoints=Param.currentbonepoints;
hand = Param.hand;
r1=hand(5);
r2=hand(6);
r3=hand(7);
r4=hand(8);
R1=hand(9);
R2=hand(10);
R3=hand(11);
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
Pr1=point2line(P,P1,P2);
Pr2=point2line(P,P2,P3);
Pr3=point2line(P,P3,P4);
Pr4=point2line(P,P4,P5);
if ((P1-Pr1)'*(C1-Pr1)<0)&&(modulus(P-Pr1)<r4)
    Pnew=Pr1+r4.*(P-Pr1)./modulus(P-Pr1);
    Flag=1;
else if ((C1-Pr1)'*(P2-Pr1)<0)&&(modulus(P-Pr1)<modulus(Pr1-P2)*r4/modulus(P2-C1))
        Pnew=C1+r4.*(P-Pr1)./modulus(P-Pr1);
        Flag=1;
    else if ((C2-Pr2)'*(C3-Pr2)<0)&&(modulus(P-Pr2)<r3)
            Pnew=Pr2+r3.*(P-Pr2)./modulus(P-Pr2);
            Flag=2;
        else if ((P2-Pr2)'*(C2-Pr2)<0)&&(modulus(P-Pr2)<modulus(Pr2-P2)*r3/modulus(P2-C2))
                Pnew=C2+r3.*(P-Pr2)./modulus(P-Pr2);
                Flag=2;
            else if ((C3-Pr2)'*(P3-Pr2)<0)&&(modulus(P-Pr2)<modulus(Pr2-P3)*r3/modulus(P3-C3))
                    Pnew=C3+r3.*(P-Pr2)./modulus(P-Pr2);
                    Flag=2;
                else if ((C4-Pr3)'*(C5-Pr3)<0)&&(modulus(P-Pr3)<r2)
                        Pnew=Pr3+r2.*(P-Pr3)./modulus(P-Pr3);
                        Flag=3;
                    else if ((P3-Pr3)'*(C4-Pr3)<0)&&(modulus(P-Pr3)<modulus(Pr3-P3)*r2/modulus(P3-C4))
                            Pnew=C4+r2.*(P-Pr3)./modulus(P-Pr3);
                            Flag=3;
                        else if ((C5-Pr3)'*(P4-Pr3)<0)&&(modulus(P-Pr3)<modulus(Pr3-P4)*r2/modulus(P4-C5))
                                Pnew=C5+r2.*(P-Pr3)./modulus(P-Pr3);
                                Flag=3;
                            else if ((C6-Pr4)'*(P5-Pr4)<0)&&(modulus(P-Pr4)<r1)
                                    Pnew=Pr4+r1.*(P-Pr4)./modulus(P-Pr4);
                                    Flag=4;
                                else if ((P4-Pr4)'*(C6-Pr4)<0)&&(modulus(P-Pr4)<modulus(Pr4-P4)*r1/modulus(P4-C6))
                                        Pnew=C6+r1.*(P-Pr4)./modulus(P-Pr4);
                                        Flag=4;
                                    else if modulus(P-P2)<R3
                                            Pnew=P2+R3.*(P-P2)./modulus(P-P2);
                                            Flag=1;
                                        else if modulus(P-P3)<R2
                                                Pnew=P3+R2.*(P-P3)./modulus(P-P3);
                                                Flag=2;
                                                else if modulus(P-P4)<R1
                                                        Pnew=P4+R1.*(P-P4)./modulus(P-P4);
                                                        Flag=3;
                                                    else
                                                            Pnew=P;
                                                            Flag=0;
                                                    end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

                                                        
    

end

