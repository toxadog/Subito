function Pnew = pushoutConstr(P,Param)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
bonepoints = Param.currentbonepoints;
hand = Param.hand;
M = Param.M;
R2=hand(10);
Constr(:,1)=bonepoints(:,3)+[-R2;0;0];
Constr(:,2)=M(:,5);
Constr(:,3)=M(:,7);
Pnew=P;
for i=1:size(Constr,2)
    if modulus([0;1;1].*P-[0;1;1].*Constr(:,i))<Param.PulleyR
        D=[0;1;1].*P-[0;1;1].*Constr(:,i);
        Pnew=P+(Param.PulleyR-modulus(D))*D/modulus(D);
    end
end
end






    

               

                                                        
    



