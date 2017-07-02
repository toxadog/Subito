function band = equalBand(band,Param)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
npoints=size(band,2);
MaxIter = 2000;
% prec=1e-8;
counter=1;
bandNew=band;
% bandNew(:,1) = pushout(bandNew(:,1),Param);
% bandNew(:,npoints) = pushout(bandNew(:,npoints),Param);
while (counter<=MaxIter)
    band=bandNew;
    for i=2:npoints-1
        D1=(band(:,i-1)-band(:,i));
        D2=(band(:,i+1)-band(:,i));
        D=D1+D2;
        bandNew(:,i)=band(:,i)+D*0.5;
        bandNew(:,i) = pushout(bandNew(:,i),Param);
        bandNew(:,i) = pushoutConstr(bandNew(:,i),Param);
        counter=counter+1;
    end
end


end

