function Tendons = iconvTendons(TendonsConv,PointsNumber)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
names=fieldnames(PointsNumber);
for i=1:size(names,1);
    for j=1:size(PointsNumber.(char(names(i))),2)
        Tendons.(char(names(i)))(:,j)=TendonsConv(PointsNumber.(char(names(i)))(j),:)';
    end
end

