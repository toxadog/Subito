function M = CreateFig(lcyl,R,class)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
global pointsdens;
switch class
    case 1       
        zn=fix(pointsdens*lcyl/2);
        jn=fix(pointsdens*2*pi*R(1)/2);
        M=zeros(3,jn,zn);
        for zc=1:zn
            for jc=1:jn
                z=zc*lcyl/(zn-1)-lcyl/(zn-1);
                fi=-pi/2+(jc-1)*2*pi/jn;
                M(:,jc,zc)=[R(1)*cos(fi);R(1)*sin(fi);z];
            end
        end
    case 2
        zn=fix(pointsdens*sum(lcyl)/2);
        jn=fix(pointsdens*2*pi*R(1)/2);
        M=zeros(3,jn,zn);
        for zc=1:zn
            for jc=1:jn
                z=zc*sum(lcyl)/(zn-1)-sum(lcyl)/(zn-1);
                fi=-pi/2+(jc-1)*2*pi/jn;
                if z<lcyl(1)
                    M(:,jc,zc)=[sqrt(R(1)^2-z^2)*cos(fi);sqrt(R(1)^2-z^2)*sin(fi);z];
                else
                    M(:,jc,zc)=[R(2)*cos(fi);R(2)*sin(fi);z];
                end
            end
        end
end

end

