function N = get_Neighbors(i,NElements,Nodes,gLines,Tendons)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
load('Connect.mat');
nN=[find(NElements(:,1)==1,1, 'last');find(NElements(:,1)==2,1, 'last');find(NElements(:,1)==3,1, 'last');...
    find(NElements(:,1)==4,1, 'last');find(NElements(:,1)==5,1, 'last')];
PrecPoint=sum(NElements(1:i-1,2));
switch NElements(i,1)
    case 1
         N=zeros(NElements(i,2),15);
    case 2
        P1=ConnectN(i-nN(1),2);
        P2=ConnectN(i-nN(1),3);
        band=Tendons.(horzcat('n',int2str(i-nN(1))));
        dim=size(band,2);
        N=neighbNodeLine(dim,P1,P2,PrecPoint);
    case 3
        P1=ConnectT(i-nN(2),2);
        P2=ConnectT(i-nN(2),3);
        band=Tendons.(horzcat('t',int2str(i-nN(2))));
        dim=size(band,2);
        N=neighbLine(dim,P1,P2,PrecPoint);
    case 4
       
        grid=Tendons.(horzcat('g',int2str(i-nN(3))));
        g=gLines.(horzcat('g',int2str(i-nN(3))));
        L1=ConnectG(i-nN(3),2);
        L2=ConnectG(i-nN(3),3);
        dim1=size(grid,3);
        dim2=size(grid,2);
        P=defineP(dim1,L1,L2,ConnectN,g,NElements,nN(1));
        N=neibGrid(dim1,dim2,P,PrecPoint);
    case 5
        grid=Tendons.(horzcat('s',int2str(i-nN(4)))); 
        dim1=size(grid,3);
        dim2=size(grid,2);
        P1=ConnectS(i-nN(4),2);
        P2=ConnectS(i-nN(4),3);
        P3=ConnectS(i-nN(4),4);
        N=neighbTriangle(dim1,dim2,P1,P2,P3,PrecPoint);
    case 6
        grid=Tendons.(horzcat('m',int2str(i-nN(5)))); 
        dim1=size(grid,3);
        dim2=size(grid,2);
        P1=ConnectM(i-nN(5),2);
        P2=ConnectM(i-nN(5),3);
        P3=ConnectM(i-nN(5),4);
        P4=ConnectM(i-nN(5),5);
        N=neighbQuad(dim1,dim2,P1,P2,P3,P4,PrecPoint) ;   
end
end
function P=defineP(dim,L1,L2,ConnectN,g,NElements,N)
P=zeros(dim,2);
P1=ConnectN(L1,2);
P2=ConnectN(L1,3);
P3=ConnectN(L2,2);
P4=ConnectN(L2,3);
for i=1:dim
    if g(1,i)==1
        P(i,1)=P1;
    else if g(1,i)==NElements(N+L1,2)+2
            P(i,1)=P2;
        else
    P(i,1)=g(1,i)-1+N+sum(NElements(N+1:N+L1-1,2));
        end
    end
    if g(2,i)==1
        P(i,2)=P3;
    else if g(2,i)==NElements(N+L2,2)+2
            P(i,2)=P4;
        else
        P(i,2)=g(2,i)-1+N+sum(NElements(N+1:N+L2-1,2));
        end
    end
end
end
function N=neighbNodeLine(dim,P1,P2,PrecPoint)
N=zeros(dim-2,15);
P3=NaN;
N(1,1:3)=[P1 2+PrecPoint P3];
for j=3:dim-2;
    P3=NaN;
    N(j-1,1:3)=[j-2+PrecPoint j+PrecPoint P3];
end
P3=NaN;
N(dim-2,1:3)=[dim-3+PrecPoint P2 P3];
end

function N=neighbLine(dim,P1,P2,PrecPoint)
N=zeros(dim-2,15);
N(1,1:2)=[P1 2+PrecPoint];
for j=3:dim-2;
    N(j-1,1:2)=[j-2+PrecPoint j+PrecPoint];
end
N(dim-2,1:2)=[dim-3+PrecPoint P2];
end

function N = neibGrid(dim1,dim2,P,PrecPoint)
N=zeros(dim1*(dim2-2),15);
for j1=1:dim1
    P1=P(j1,1);
    P2=P(j1,2);
    num=1+(dim2-2)*(j1-1);
    pos=num+PrecPoint;
    N(num,1:2)=[P1,pos+1];
    for j=3:dim2-2;
        num=j-1+(dim2-2)*(j1-1);
        pos=num+PrecPoint;
        N(num,1:2)=[pos-1, pos+1];
    end
    num=dim2-2+(dim2-2)*(j1-1);
    pos=num+PrecPoint;
    N(num,1:2)=[pos-1 P2];
end
end
function N=neighbTriangle(dim1,dim2,P1,P2,P3,PrecPoint)
N=zeros(dim1*(dim2-1)-2,15);
T=dim2-1;
for j1=1:dim1
    switch j1
        case 1
            num=1;
            pos=num+PrecPoint;
            N(num,1:3)=[P1 pos+1,pos+T];
            for j=3:dim2-2
                num=j-1;
                pos=num+PrecPoint;
                N(num,1:3)=[pos-1 pos+1,pos+T];
            end
            num=dim2-2;
            pos=num+PrecPoint;
            N(num,1:3)=[pos-1,P3, pos+T];
         case 2
             num=1+T-1;
             pos=num+PrecPoint;
             N(num,1:3)=[ pos+1,P1,pos+T];
             for j=2:dim2-2
                 num=j+T-1;
                 pos=num+PrecPoint;
                 N(num,1:4)=[pos-1 pos+1,pos-T,pos+T];
             end
             num=dim2-1+T-1;
             pos=num+PrecPoint;
             N(num,1:4)=[pos-1,P3,pos-T, pos+T];
         case  dim1-1
             num=1+T*(j1-1)-1;
             pos=num+PrecPoint;
             N(num,1:3)=[ pos+1,pos-T,P2];
             for j=2:dim2-2
                 num=j+T*(j1-1)-1;
                 pos=num+PrecPoint;
                 N(num,1:4)=[pos-1 pos+1,pos-T,pos+T-1];
             end
             num=dim2-1+T*(j1-1)-1;
             pos=num+PrecPoint;
             N(num,1:4)=[pos-1,P3,pos-T, pos+T-1];       
         case dim1
             num=1+T*(j1-1)-1;
             pos=num+PrecPoint;
             N(num,1:3)=[P2 pos+1,pos-T+1];
             for j=3:dim2-2
                 num=j-1+T*(j1-1)-1;
                 pos=num+PrecPoint;
                 N(num,1:3)=[pos-1 pos+1,pos-T+1];
             end
             num=dim2-2+T*(j1-1)-1;
             pos=num+PrecPoint;
             N(num,1:3)=[pos-1,P3, pos-T+1];       
        otherwise
            num=1+T*(j1-1)-1;
            pos=num+PrecPoint;
            N(num,1:3)=[ pos+1,pos-T,pos+T];
            for j=2:dim2-2
                num=j+T*(j1-1)-1;
                pos=num+PrecPoint;
                N(num,1:4)=[pos-1 pos+1,pos-T,pos+T];
            end
            num=dim2-1+T*(j1-1)-1;
            pos=num+PrecPoint;
            N(num,1:4)=[pos-1,P3,pos-T, pos+T];  
    end
end
end
function N=neighbQuad(dim1,dim2,P1,P2,P3,P4,PrecPoint)
N=zeros(dim1*dim2-4,15);
 T=dim2;
        for j1=1:dim1 
            switch j1
                case 1
                    num=1;
                    pos=num+PrecPoint;
                    N(num,1:3)=[P1 pos+1,pos+T-1];
                    for j=3:dim2-2
                        num=j-1;
                        pos=num+PrecPoint;
                        N(num,1:3)=[pos-1 pos+1,pos+T-1];
                    end
                    num=dim2-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P4, pos+T-1];
                case 2
                    num=1+T-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,P1,pos+T];
                    for j=2:dim2-1
                        num=j+T-2;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T+1,pos+T];
                    end
                    num=dim2+T-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P4,pos+T];
                case  dim1-1
                    num=1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,pos-T,P2];
                    for j=2:dim2-1
                        num=j+T*(j1-1)-2;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T,pos+T-1];
                    end
                    num=dim2+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,pos-T, P3];
                    
                case dim1
                    num=1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[P2 pos+1,pos-T+1];
                    for j=3:dim2-2
                        num=j-1+T*(j1-1)-2;
                        pos=num+PrecPoint;
                        N(num,1:3)=[pos-1 pos+1,pos-T+1];
                    end
                    num=dim2-1-1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P3, pos-T+1];
                    
                otherwise
                    num=1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,pos-T,pos+T];
                    for j=2:dim2-1
                        num=j+T*(j1-1)-2;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T,pos+T];
                    end
                    num=dim2+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,pos-T, pos+T];  
            end
        end 
end

