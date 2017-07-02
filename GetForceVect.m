function Force = GetForceVect(P1,P2,Param,Fabs)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Points=CreateBand(P1,P2,20);
angMAX=0;
MAXn=size(Points,2);
for i=2:size(Points,2)-1
    Points(:,i)=pushoutShort(Points(:,i),Param);
    ang=abs(getangle(Points(:,i)-Points(:,1),Points(:,size(Points,2))-Points(:,1)));
%     dist=point2lineDist(Points(:,i),Points(:,1),Points(:,size(Points,2)));
    if ang>angMAX
        angMAX=ang;
        MAXn=i;
    end
end
Force=Fabs*(Points(:,MAXn)-P1)/modulus(Points(:,MAXn)-P1);

end

