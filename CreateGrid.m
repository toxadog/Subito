function [Grid, Line] = CreateGrid(Band1,Band2,zone,PConstr,Param,npoints)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Lg=[size(Band1,2) size(Band2,2)];
zone2=[zone(1,2)-zone(1,1) zone(2,2)-zone(2,1)];
LL=round(Lg.*zone2);
if zone(1,1)==0
    Points1=1:round(LL(1));
    Points2=Lg(2)+1-round(LL(2)):Lg(2);
else
    Points1=Lg(1)+1-round(LL(1)):Lg(1);
    Points2=1:round(LL(2));
end
% Nodes=[Nodes;ILBU(:,Points1)';EMB(:,Points2)';ILBR(:,Points1)'];
[Lline1 Rline1] = getGrid(Points1,Points2);
Line=[Lline1;Rline1];
for i=1:size(Line,2)
    if isnan(PConstr)
        Grid(:,:,i)=CreateBand(Band1(:,Line(1,i)),Band2(:,Line(2,i)),npoints);
    else
        Grid(:,:,i)=CreateBandConstr(Band1(:,Line(1,i)),Band2(:,Line(2,i)),PConstr,Param,npoints);
    end
end


end

