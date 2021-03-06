function drawband(Tendons)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
global haxes
axes(haxes);
names=fieldnames(Tendons);
if size(Tendons.(char(names(1))),1)==3
    for i=1:size(names,1);
        band=Tendons.(char(names(i)));
        bname=char(names(i));
        if (bname(1)=='t')||(bname(1)=='n')
                linewidth=4;
        Ref=band(:,1);
        for j=2:size(band,2);
            line([Ref(1) band(1,j)],[Ref(3) band(3,j)],[Ref(2) band(2,j)],'Color',[0.8,0.2,0.2],'LineWidth',linewidth);
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
            surf(X,Z,Y,'FaceColor',[0.9,0.3,0.3],'EdgeColor',[0.8,0.2,0.2])
            else
                linewidth=1;
                band=Tendons.(char(names(i)));
                for c2=1:size(Tendons.(char(names(i))),3)
                   Ref=band(:,1,c2);
                   for j=2:size(band,2);
                       line([Ref(1) band(1,j,c2)],[Ref(3) band(3,j,c2)],[Ref(2) band(2,j,c2)],'Color',[0.8,0.2,0.2],'LineWidth',linewidth);
                       Ref=band(:,j,c2);
                   end
                end
            end
        end
    end
else
    ColorStruct=makemap(Tendons);
    for i=1:size(names,1);
        band=Tendons.(char(names(i)));
        color=ColorStruct.(char(names(i)));
        Ref=band(:,1);
        for j=2:size(band,2);
            line([Ref(1) band(1,j)],[Ref(3) band(3,j)],[Ref(2) band(2,j)],'Color',color(:,j)','LineWidth',4);
            Ref=band(:,j);
        end
    end
end
 
    
    
    
end

