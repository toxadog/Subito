names=fieldnames(Tendons);
err=zeros(size(names,1),1);
for i=1:size(names,1);
band1=Tendons.(char(names(i)));  
band2=Tendons2.(char(names(i)));  
if ndims(band1)==2
    for j=1:size(band1,2);
        err(i)=sqrt(sum(sum((band1-band2).^2)))/size(band1,2);
    end
else
    for j=1:size(band1,2);
        for k=1:size(band1,3);
            err(i)=sqrt(sum(sum(sum((band1-band2).^2))))/(size(band1,3)*size(band1,2));
%             band(1:3,j,k)=pushoutConstr(band(1:3,j,k),Param);
        end
    end
end
end