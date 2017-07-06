function N = get_Neighbors(i,NElements,Nodes,Tendons)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
nN=[find(NElements(:,1)==1,1, 'last');find(NElements(:,1)==2,1, 'last');find(NElements(:,1)==3,1, 'last');...
    find(NElements(:,1)==4,1, 'last');find(NElements(:,1)==5,1, 'last')];
PrecPoint=sum(NElements(1:i-1,2));
N=zeros(NElements(i,2),15);
switch NElements(i,1)
    case 1
        T=Nodes(:,i)';
    case 2
        P1=NaN;
        P2=NaN;
        P3=NaN;
        band=Tendons.(horzcat('n',int2str(i-nN(1))));
        npoints=size(band,2);
        N(1,1:2)=[P1 2+PrecPoint];
        for j=3:npoints-2;
            P3=NaN;
            N(j-1,1:3)=[j-2+PrecPoint j+PrecPoint P3];
        end
        N(npoints-2,1:2)=[npoints-3+PrecPoint P2];
    case 3
        P1=NaN;
        P2=NaN;
        band=Tendons.(horzcat('t',int2str(i-nN(2))));
        npoints=size(band,2);
        N(1,1:2)=[P1 2+PrecPoint];
        for j=3:npoints-2;
            N(j-1,1:2)=[j-2+PrecPoint j+PrecPoint];
        end
        N(npoints-2,1:2)=[npoints-3+PrecPoint P2];
    case 4
        grid=Tendons.(horzcat('g',int2str(i-nN(3))));
        P1=NaN;
        P2=NaN;
        npoints=size(grid,2);
        for j1=1:size(grid,3) 
            N(1+(npoints-2)*(j1-1),1:2)=[P1 2+PrecPoint+(npoints-2)*(j1-1)];
            for j=3:npoints-2;
                N(j-1+(npoints-2)*(j1-1),1:2)=[j-2+PrecPoint+(npoints-2)*(j1-1) j+PrecPoint+(npoints-2)*(j1-1)];
            end
            N(npoints-2+(npoints-2)*(j1-1),1:2)=[npoints-3+PrecPoint+(npoints-2)*(j1-1) P2];
        end
    case 5
        grid=Tendons.(horzcat('s',int2str(i-nN(4)))); 
        npoints=size(grid,2);
        P1=NaN;
        P2=NaN;
        P3=NaN;
        T=npoints-1;
        for j1=1:size(grid,3) 
            switch j1
                case 1
                    num=1;
                    pos=num+PrecPoint;
                    N(num,1:3)=[P1 pos+1,pos+T];
                    for j=3:npoints-2
                        num=j-1;
                        pos=num+PrecPoint;
                        N(num,1:3)=[pos-1 pos+1,pos+T];
                    end
                    num=npoints-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P3, pos+T];
                case 2
                    num=1+T-1;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,P1,pos+T];
                    for j=2:npoints-2
                        num=j+T-1;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T,pos+T];
                    end
                    num=npoints-1+T-1;
                    pos=num+PrecPoint;
                    N(num,1:4)=[pos-1,P3,pos-T, pos+T];
                    
                case  size(grid,3)-1
                    num=1+T*(j1-1)-1;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,pos-T,P2];
                    for j=2:npoints-2
                        num=j+T*(j1-1)-1;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T,pos+T];
                    end
                    num=npoints-1+T*(j1-1)-1;
                    pos=num+PrecPoint;
                    N(num,1:4)=[pos-1,P3,pos-T, pos+T];
                    
                case size(grid,3)
                    num=1+T*(j1-1)-1;
                    pos=num+PrecPoint;
                    N(num,1:3)=[P2 pos+1,pos-T];
                    for j=3:npoints-2
                        num=j-1+T*(j1-1)-1;
                        pos=num+PrecPoint;
                        N(num,1:3)=[pos-1 pos+1,pos-T];
                    end
                    num=npoints-2+T*(j1-1)-1;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P3, pos-T];
                    
                otherwise
                    num=1+T*(j1-1)-1;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,pos-T,pos+T];
                    for j=2:npoints-2
                        num=j+T*(j1-1)-1;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T,pos+T];
                    end
                    num=npoints-1+T*(j1-1)-1;
                    pos=num+PrecPoint;
                    N(num,1:4)=[pos-1,P3,pos-T, pos+T];  
            end
        end
        case 6
        grid=Tendons.(horzcat('m',int2str(i-nN(4)))); 
        npoints=size(grid,2);
        P1=NaN;
        P2=NaN;
        P3=NaN;
        P4=NaN;
        T=npoints;
        for j1=1:size(grid,3) 
            switch j1
                case 1
                    num=1;
                    pos=num+PrecPoint;
                    N(num,1:3)=[P1 pos+1,pos+T];
                    for j=3:npoints-2
                        num=j-1;
                        pos=num+PrecPoint;
                        N(num,1:3)=[pos-1 pos+1,pos+T];
                    end
                    num=npoints-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P4, pos+T];
                case 2
                    num=1+T-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,P1,pos+T];
                    for j=2:npoints-1
                        num=j+T-2;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T-1,pos+T];
                    end
                    num=npoints+T-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P4,pos+T];
                case  size(grid,3)-1
                    num=1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,pos-T,P2];
                    for j=2:npoints-1
                        num=j+T*(j1-1)-2;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T,pos+T-1];
                    end
                    num=npoints+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,pos-T, P3];
                    
                case size(grid,3)
                    num=1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[P2 pos+1,pos-T];
                    for j=3:npoints-2
                        num=j-1+T*(j1-1)-2;
                        pos=num+PrecPoint;
                        N(num,1:3)=[pos-1 pos+1,pos-T];
                    end
                    num=npoints-1-1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P3, pos-T];
                    
                otherwise
                    num=1+T*(j1-1)-2;
                    pos=1+PrecPoint;
                    N(num,1:3)=[ pos+1,pos-T,pos+T];
                    for j=2:npoints-1
                        num=j+T*(j1-1)-2;
                        pos=1+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T,pos+T];
                    end
                    num=npoints+T*(j1-1)-2;
                    pos=1+PrecPoint;
                    N(num,1:3)=[pos-1,pos-T, pos+T];  
            end
        end      
end
end


