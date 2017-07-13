function ColorStruct = makemap(F,Map)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
Tmax = max(F(~isnan(F)));
Tmin = min(F(~isnan(F)));
ColorStruct.Tmax=Tmax;
ColorStruct.Tmin=Tmin;
Colors=jet(256);
NNeigmax=size(F,2);
names=fieldnames(Map);
for i=1:size(names,1);
    bname=char(names(i));
    if (bname(1)=='t')||(bname(1)=='n') 
        for j=1:size(Map.(bname),2)
%             pos0=find(isnan(F(Map.(char(names(i)))(j),:)),1);
%             if isempty(pos0)
%                 NNeig=NNeigmax;
%             else
%                 NNeig=pos0(1)-1;
%             end
                ColorStruct.(bname)(:,j)=getcolor(mean(F(Map.(char(names(i)))(j),1)),Colors,Tmax,Tmin);
        end
    else if (bname(1)=='s')||(bname(1)=='m')
            for j=1:size(Map.(char(names(i))),3);
                for k=1:size(Map.(char(names(i))),2);
                    pos0=find(isnan(F(Map.(char(names(i)))(1,k,j),:)),1);
                    if isempty(pos0)
                        NNeig=NNeigmax;
                    else
                        NNeig=pos0(1)-1;
                    end
                    ColorStruct.(char(names(i)))(j,k)=(mean(F(Map.(bname)(1,k,j),1:NNeig))-Tmin)/(Tmax-Tmin);
                end
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
                    col=getcolor(mean(F(Map.(char(names(i)))(1,k,j),1:NNeig)),Colors,Tmax,Tmin);
                    ColorStruct.(char(names(i)))(1,k,j)=col(1);
                    ColorStruct.(char(names(i)))(2,k,j)=col(2);
                    ColorStruct.(char(names(i)))(3,k,j)=col(3);
                end
            end
        end
    end
end
end
function col = getcolor(x,Colors,Tmax,Tmin)
 if isnan(x)
    col=[0; 0; 0];
 else
    col=Colors(1+round(249*(x-Tmin)/(Tmax-Tmin)),:)';
 end
end

