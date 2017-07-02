function [Pen dir] = penalty(P,Param)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
bonepoints = Param.currentbonepoints;
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
Q1=(P1+P2)/2;
Q2=(P2+P3)/2;
Q3=(P3+P4)/2;
Q4=(P4+P5)/2; 
 


if (modulus(P-Q2)<sqrt(l3^2/4+r3^2))&&(modulus(P-P3)>=R2)&&(modulus(P-P2)>=R3)&&(modulus(P-Q1)>=sqrt(l4^2/4+r4^2))&&(modulus(P-Q3)>=sqrt(l2^2/4+r2^2))
% if (modulus(P-Q2)<sqrt(l3^2/4+r3^2))&&(modulus(P-P3)>=R2)&&(modulus(P-P2)>=R3)
    Pr2=point2line(P,P2,P3);
    if ((C2-Pr2)'*(C3-Pr2)<0)&&(modulus(P-Pr2)<r3)
        Pen=modulus(P-Pr2)-r3;
        dir=P-Pr2;
    else
        Pen=0;
        dir=[0;0;0];
    end
        
else if (modulus(P-Q1)<sqrt(l4^2/4+r4^2))&&(modulus(P-P2)>=R3)&&(modulus(P-Q2)>=sqrt(l3^2/4+r3^2))
        Pr1=point2line(P,P1,P2);
        if ((P1-Pr1)'*(C1-Pr1)<0)&&(modulus(P-Pr1)<r4)
            Pen=modulus(P-Pr1)-r4;
            dir=P-Pr1;
        else
            Pen=0;
            dir=[0;0;0];
        end
    else if (modulus(P-Q3)<sqrt(l2^2/4+r2^2))&&(modulus(P-P3)>=R2)&&(modulus(P-P4)>=R1)&&(modulus(P-Q2)>=sqrt(l3^2/4+r3^2))&&(modulus(P-Q4)>=sqrt(l1^2/4+r1^2))
            Pr3=point2line(P,P3,P4);
            if ((C4-Pr3)'*(C5-Pr3)<0)&&(modulus(P-Pr3)<r2)
                Pen=modulus(P-Pr3)-r2;
                dir=P-Pr3;
            else
                Pen=0;
                dir=[0;0;0];
            end
        else if (modulus(P-Q4)<sqrt(l1^2/4+r1^2))&&(modulus(P-P4)>=R1)&&(modulus(P-Q3)>=sqrt(l2^2/4+r2^2))
                Pr4=point2line(P,P4,P5);
                if ((C6-Pr4)'*(P5-Pr4)<0)&&(modulus(P-Pr4)<r1)
                    Pen=modulus(P-Pr4)-r1;
                    dir=P-Pr4;
                    else
                        Pen=0;
                        dir=[0;0;0];
                end
            else if modulus(P-P2)<R3                        
                        Pr1=point2line(P,P1,P2);
                    if ((C1-Pr1)'*(P2-Pr1)<0)&&(modulus(P-Pr1)<modulus(Pr1-P2)*r4/modulus(P2-C1)) 
                        Pen=-sqrt((modulus(P-Pr1)-r4)^2+(modulus(C1-Pr1))^2);
                        dir=(P-Pr1)*(1-r4/modulus(P-Pr1))+(C1-Pr1);
                    else
                        Pr2=point2line(P,P2,P3);
                        if ((P2-Pr2)'*(C2-Pr2)<0)&&(modulus(P-Pr2)<modulus(Pr2-P2)*r3/modulus(P2-C2))
                           Pen=-sqrt((modulus(P-Pr2)-r3)^2+(modulus(C2-Pr2))^2);
                           dir=(P-Pr2)*(1-r3/modulus(P-Pr2))+(C2-Pr2);
                        else if ((C2-Pr2)'*(C3-Pr2)<0)&&(modulus(P-Pr2)<r3)
                                Pen=modulus(P-Pr2)-r3;
                                dir=P-Pr2;
                            else if ((P1-Pr1)'*(C1-Pr1)<0)&&(modulus(P-Pr1)<r4)
                                    Pen=modulus(P-Pr1)-r4;
                                    dir=P-Pr1;
                                else
                            Pen=modulus(P-P2)-R3;
                            dir=P-P2;
                                end
                            end
                        end
                    end
                    else if modulus(P-P3)<R2
                                Pr2=point2line(P,P2,P3);                                
                            if ((C3-Pr2)'*(P3-Pr2)<0)&&(modulus(P-Pr2)<modulus(Pr2-P3)*r3/modulus(P3-C3))
                                Pen=-sqrt((modulus(P-Pr2)-r3)^2+(modulus(C3-Pr2))^2);
                                dir=(P-Pr2)*(1-r3/modulus(P-Pr2))+(C3-Pr2);
                            else
                                Pr3=point2line(P,P3,P4);
                                if ((P3-Pr3)'*(C4-Pr3)<0)&&(modulus(P-Pr3)<modulus(Pr3-P3)*r2/modulus(P3-C4))
                                    Pen=-sqrt((modulus(P-Pr3)-r2)^2+(modulus(C4-Pr3))^2);
                                    dir=(P-Pr3)*(1-r2/modulus(P-Pr3))+(C4-Pr3);
                                else if ((C2-Pr2)'*(C3-Pr2)<0)&&(modulus(P-Pr2)<r3)
                                        Pen=modulus(P-Pr2)-r3;
                                        dir=P-Pr2;
                                    else if ((C4-Pr3)'*(C5-Pr3)<0)&&(modulus(P-Pr3)<r2)
                                            Pen=modulus(P-Pr3)-r2;
                                            dir=P-Pr3;
                                        else
                                            Pen=modulus(P-P3)-R2;
                                            dir=P-P3;
                                        end
                                    end
                                end
                            end
                            else if modulus(P-P4)<R1
                                        Pr3=point2line(P,P3,P4);                                        
                                    if ((C5-Pr3)'*(P4-Pr3)<0)&&(modulus(P-Pr3)<modulus(Pr3-P4)*r2/modulus(P4-C5))
                                        Pen=-sqrt((modulus(P-Pr3)-r2)^2+(modulus(C5-Pr3))^2);
                                        dir=(P-Pr3)*(1-r2/modulus(P-Pr3))+(C5-Pr3);
                                    else
                                        Pr4=point2line(P,P4,P5);
                                        if ((P4-Pr4)'*(C6-Pr4)<0)&&(modulus(P-Pr4)<modulus(Pr4-P4)*r1/modulus(P4-C6))
                                            Pen=-sqrt((modulus(P-Pr4)-r1)^2+(modulus(C6-Pr4))^2);
                                            dir=(P-Pr4)*(1-r1/modulus(P-Pr4))+(C6-Pr4);
                                        else if ((C4-Pr3)'*(C5-Pr3)<0)&&(modulus(P-Pr3)<r2)
                                                Pen=modulus(P-Pr3)-r2;
                                                dir=P-Pr3;
                                            else if ((C6-Pr4)'*(P5-Pr4)<0)&&(modulus(P-Pr4)<r1)
                                                    Pen=modulus(P-Pr4)-r1;
                                                    dir=P-Pr4;
                                                else
                                                    Pen=modulus(P-P4)-R1;
                                                    dir=P-P4;
                                                end
                                            end
                                        end
                                    end
                                else if (modulus(P-Q1)<sqrt(l4^2/4+r4^2))&&(modulus(P-Q2)<sqrt(l3^2/4+r3^2))
                                        Pr1=point2line(P,P1,P2);
                                        if ((P1-Pr1)'*(C1-Pr1)<0)&&(modulus(P-Pr1)<r4)
                                            Pen=modulus(P-Pr1)-r4;
                                            dir=P-Pr1;
                                        else
                                            Pr2=point2line(P,P2,P3);
                                            if ((C2-Pr2)'*(C3-Pr2)<0)&&(modulus(P-Pr2)<r3)
                                                Pen=modulus(P-Pr2)-r3;
                                                dir=P-Pr2;
                                            else
                                                Pen=0;
                                                dir=[0;0;0];
                                            end
                                        end
                                    else if (modulus(P-Q2)<sqrt(l3^2/4+r3^2))&&(modulus(P-Q3)<sqrt(l2^2/4+r2^2))
                                            Pr2=point2line(P,P2,P3);
                                            if ((C2-Pr2)'*(C3-Pr2)<0)&&(modulus(P-Pr2)<r3)
                                                 Pen=modulus(P-Pr2)-r3;
                                                 dir=P-Pr2;
                                            else
                                                Pr3=point2line(P,P3,P4);
                                            if ((C4-Pr3)'*(C5-Pr3)<0)&&(modulus(P-Pr3)<r2)
                                                Pen=modulus(P-Pr3)-r2;
                                                dir=P-Pr3;
                                            else
                                                Pen=0;
                                                dir=[0;0;0];
                                            end
                                            end
                                        else if (modulus(P-Q3)<sqrt(l2^2/4+r2^2))&&(modulus(P-Q4)<sqrt(l1^2/4+r1^2))
                                                Pr3=point2line(P,P3,P4);
                                                if ((C4-Pr3)'*(C5-Pr3)<0)&&(modulus(P-Pr3)<r2)
                                                    Pen=modulus(P-Pr3)-r2;
                                                    dir=P-Pr3;
                                                else
                                                    Pr4=point2line(P,P4,P5);
                                                    if ((C6-Pr4)'*(P5-Pr4)<0)&&(modulus(P-Pr4)<r1)
                                                        Pen=modulus(P-Pr4)-r1;
                                                        dir=P-Pr4;
                                                    else
                                                        Pen=0;
                                                        dir=[0;0;0];
                                                    end
                                                end
                                            else
                                                Pen=0;
                                                dir=[0;0;0];
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






    

               

                                                        
    



