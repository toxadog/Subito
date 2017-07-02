function Tendons = AddForces(Tendons, Param)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
TendS = Param.TendS;
Elast = Param.Elast;
pointsdens_new = Param.pointsdens_new;
names=fieldnames(Tendons);
for i=1:size(names,1);
    l0=1/pointsdens_new(i);    
    if size(Tendons.(char(names(i))),1)==3
        band=[Tendons.(char(names(i)));zeros(1,size(Tendons.(char(names(i))),2))];
    else
        band=Tendons.(char(names(i)));
    end
            
    Ref=band(1:3,1);
    for j=2:size(band,2);
        k=Ref-band(1:3,j);
        Force=sign(modulus(k)-l0)*1e-3*modulus(TendS(i)*Elast(i)*1000*pointsdens_new(i)*k*(modulus(k)-l0)/modulus(k));
        Ref=band(1:3,j);
        band(4,j)=Force;
    end
    Tendons.(char(names(i)))=band;
end
end

