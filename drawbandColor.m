function drawbandColor(Tendons,ColorStruct)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
global haxes
axes(haxes);
%     ColorStruct=makemap(Tendons);
%     for i=1:size(names,1);
%         band=Tendons.(char(names(i)));
%         color=ColorStruct.(char(names(i)));
%         Ref=band(:,1);
%         for j=2:size(band,2);
%             line([Ref(1) band(1,j)],[Ref(3) band(3,j)],[Ref(2) band(2,j)],'Color',color(:,j)','LineWidth',4);
%             Ref=band(:,j);
%         end
%     end
 
names=fieldnames(Tendons);
    for i=1:size(names,1);
        band=Tendons.(char(names(i)));
        bname=char(names(i));
        if (bname(1)=='t')||(bname(1)=='n')
                linewidth=4;
        Ref=band(:,1);
        for j=2:size(band,2);
            line([Ref(1) band(1,j)],[Ref(3) band(3,j)],[Ref(2) band(2,j)],'Color',ColorStruct.(char(names(i)))(:,j),'LineWidth',linewidth);
%             plot3(band(1,j),band(3,j),band(2,j),'ro')
            Ref=band(:,j);
        end
        else if (bname(1)=='s')||(bname(1)=='m')
            X=zeros(size(Tendons.(char(names(i))),2),size(Tendons.(char(names(i))),3));
            Y=zeros(size(Tendons.(char(names(i))),2),size(Tendons.(char(names(i))),3));
            Z=zeros(size(Tendons.(char(names(i))),2),size(Tendons.(char(names(i))),3));
            for c1=1:size(Tendons.(char(names(i))),2)
                for c2=1:size(Tendons.(char(names(i))),3)
                    X(c1,c2)=Tendons.(char(names(i)))(1,c1,c2);
                    Y(c1,c2)=Tendons.(char(names(i)))(2,c1,c2);
                    Z(c1,c2)=Tendons.(char(names(i)))(3,c1,c2);
                end
            end
            hold on;
            surf(X,Z,Y,ColorStruct.(char(names(i)))')
            else
                linewidth=1;
                band=Tendons.(char(names(i)));
                Ref=band(:,1,1);
                for c2=1:size(Tendons.(char(names(i))),3)
                    
                    for j=2:size(band,2);
                       bcolor=[ColorStruct.(char(names(i)))(1,j,c2) ColorStruct.(char(names(i)))(2,j,c2) ColorStruct.(char(names(i)))(3,j,c2)];
                       line([Ref(1) band(1,j,c2)],[Ref(3) band(3,j,c2)],[Ref(2) band(2,j,c2)],'Color',bcolor,'LineWidth',linewidth);
                       Ref=band(:,j,c2);
                   end
                   Ref=band(:,1,c2);
                end
            end
        end
    end
    caxis([0 1]);
    Ylimits=get(colorbar,'YLim');
   colorbar('YLim',Ylimits,'YTick',Ylimits(1):(Ylimits(2)-Ylimits(1))/10:Ylimits(2),'YTickLabel',eval(sprintf('%.2f',ColorStruct.Tmin)):(eval(sprintf('%.2f',ColorStruct.Tmax))-eval(sprintf('%.2f',ColorStruct.Tmin)))/10:eval(sprintf('%.2f',ColorStruct.Tmax)));
end

