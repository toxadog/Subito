function ColorStruct = makemap(Tendons)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
% global haxes
% axes(haxes);
T=[];
names=fieldnames(Tendons);
for i=1:size(names,1)
    band=Tendons.(char(names(i)));
    for  j=2:size(band,2)
        T=[T band(4,j)];
    end
end
Tmax=max(T);
Tmin=min(T);
Colors=jet(256);
% Colors=pink(256);
for i=1:size(names,1)
    band=Tendons.(char(names(i)));
    col=zeros(3,size(band,2));
    for  j=2:size(band,2)
        if isnan((band(4,j)-Tmin)/(Tmin-Tmax));
            col(:,j)=[0;0;0];
        else
            col(:,j)=Colors(1+round(249*(band(4,j)-Tmin)/(Tmax-Tmin)),:)';
        end
    end
    ColorStruct.(char(names(i)))=col;
end
   Ylimits=get(colorbar,'YLim');
   %colormap pink;
   colormap jet;
   colorbar('YLim',Ylimits,'YTick',Ylimits(1):(Ylimits(2)-Ylimits(1))/10:Ylimits(2),'YTickLabel',eval(sprintf('%.2f',Tmin)):(eval(sprintf('%.2f',Tmax))-eval(sprintf('%.2f',Tmin)))/10:eval(sprintf('%.2f',Tmax)));
end

