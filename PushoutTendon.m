function Tendons = PushoutTendon(Tendons,Param)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
names=fieldnames(Tendons);
for i=1:size(names,1);
band=Tendons.(char(names(i)));  
if ndims(band)==2
    for j=1:size(band,2);
        band(1:3,j)=pushout(band(1:3,j),Param);
    end
else
    for j=1:size(band,2);
        for k=1:size(band,3);
            band(1:3,j,k)=pushout(band(1:3,j,k),Param);
%             band(1:3,j,k)=pushoutConstr(band(1:3,j,k),Param);
        end
    end
end
    
Tendons.(char(names(i)))=band;
end
end



