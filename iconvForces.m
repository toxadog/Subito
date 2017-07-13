function Forces = iconvForces(F,Map)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
NNeigmax=size(F,2);
names=fieldnames(Map);
for i=1:size(names,1);
    if ismatrix(Map.(char(names(i))))
        for j=1:size(Map.(char(names(i))),2)
%             pos0=find(isnan(F(Map.(char(names(i)))(j),:)),1);
%             if isempty(pos0)
%                 NNeig=NNeigmax;
%             else
%                 NNeig=pos0(1)-1;
%             end
                Forces.(char(names(i)))(j)=mean(F(Map.(char(names(i)))(j),1));
        end
    else
    for j=1:size(Map.(char(names(i))),3);
        for k=1:size(Map.(char(names(i))),2);
            pos0=find(isnan(F(Map.(char(names(i)))(1,k,j),:)),1);
            if isempty(pos0)
                NNeig=NNeigmax;
            else
                NNeig=pos0(1)-1;
            end
            Forces.(char(names(i)))(j,k)=mean(F(Map.(char(names(i)))(1,k,j),1:NNeig)); 
        end
    end
    end
end

