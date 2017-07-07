function Tendons = iconvTendons(TendonsConv,Map)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
names=fieldnames(Map);
for i=1:size(names,1);
    if ismatrix(Map.(char(names(i))))
        for j=1:size(Map.(char(names(i))),2)
            Tendons.(char(names(i)))(:,j)=TendonsConv(Map.(char(names(i)))(j),:)';
        end
    else
    for j=1:size(Map.(char(names(i))),2);
        for k=1:size(Map.(char(names(i))),3);
            Tendons.(char(names(i)))(:,j,k)=TendonsConv(Map.(char(names(i)))(1,j,k),:)';
        end
    end
    end
end

