function N = get_Neighbors(NElements,gLines,Tendons)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
load('Connect.mat');
nN=[find(NElements(:,1)==1,1, 'last');find(NElements(:,1)==2,1, 'last');find(NElements(:,1)==3,1, 'last');...
    find(NElements(:,1)==4,1, 'last');find(NElements(:,1)==5,1, 'last')];
NEl=size(NElements,1);
N=zeros(sum(NElements(:,2)),15);
counter=1;
for i=1:NEl
    PrecPoint=sum(NElements(1:i-1,2));
switch NElements(i,1)
    case 1
         N(counter:counter+NElements(i,2)-1,:)=zeros(NElements(i,2),15);
    case 2
        P1=ConnectN(i-nN(1),2);
        P2=ConnectN(i-nN(1),3);
        N(P1,find(N(P1,:)==0,1,'first'))=counter;
        N(P2,find(N(P2,:)==0,1,'first'))=counter+NElements(i,2)-1;
        band=Tendons.(horzcat('n',int2str(i-nN(1))));
        dim=size(band,2);
        N(counter:counter+NElements(i,2)-1,:)=neighbNodeLine(dim,P1,P2,PrecPoint);
    case 3
        P1=ConnectT(i-nN(2),2);
        P2=ConnectT(i-nN(2),3);
        N(P1,find(N(P1,:)==0,1,'first'))=counter;
        N(P2,find(N(P2,:)==0,1,'first'))=counter+NElements(i,2)-1;
        band=Tendons.(horzcat('t',int2str(i-nN(2))));
        dim=size(band,2);
        N(counter:counter+NElements(i,2)-1,:)=neighbLine(dim,P1,P2,PrecPoint);
    case 4
       
        grid=Tendons.(horzcat('g',int2str(i-nN(3))));
        g=gLines.(horzcat('g',int2str(i-nN(3))));
        L1=ConnectG(i-nN(3),2);
        L2=ConnectG(i-nN(3),3);
        dim1=size(grid,3);
        dim2=size(grid,2);
        P=defineP(dim1,L1,L2,ConnectN,g,NElements,nN(1));
        [N(counter:counter+NElements(i,2)-1,:), NodeLink]=neibGrid(dim1,dim2,P,PrecPoint);
        NodeLink(:,2)=NodeLink(:,2)+counter-1;
        for k=1:size(NodeLink,1)
            N(NodeLink(k,1),find(N(NodeLink(k,1),:)==0,1,'first'))=NodeLink(k,2);
        end
    case 5
        grid=Tendons.(horzcat('s',int2str(i-nN(4)))); 
        dim1=size(grid,3);
        dim2=size(grid,2);
        P1=ConnectS(i-nN(4),2);
        P2=ConnectS(i-nN(4),3);
        P3=ConnectS(i-nN(4),4);
        [N(counter:counter+NElements(i,2)-1,:), NodeLink]=neighbTriangle(dim1,dim2,P1,P2,P3,PrecPoint);
         NodeLink(:,2)=NodeLink(:,2)+counter-1;
        for k=1:size(NodeLink,1)
            N(NodeLink(k,1),find(N(NodeLink(k,1),:)==0,1,'first'))=NodeLink(k,2);
        end
    case 6
        grid=Tendons.(horzcat('m',int2str(i-nN(5)))); 
        dim1=size(grid,3);
        dim2=size(grid,2);
        P1=ConnectM(i-nN(5),2);
        P2=ConnectM(i-nN(5),3);
        P3=ConnectM(i-nN(5),4);
        P4=ConnectM(i-nN(5),5);
        [N(counter:counter+NElements(i,2)-1,:), NodeLink]=neighbQuad(dim1,dim2,P1,P2,P3,P4,PrecPoint);
        NodeLink(:,2)=NodeLink(:,2)+counter-1;
        for k=1:size(NodeLink,1)
            N(NodeLink(k,1),find(N(NodeLink(k,1),:)==0,1,'first'))=NodeLink(k,2);
        end
end
counter=counter+NElements(i,2);
end
end

function N=neighbNodeLine(dim,P1,P2,PrecPoint)
N=zeros(dim-2,15);
N(1,1:2)=[P1 2+PrecPoint];
for j=3:dim-2;
    P3=NaN;
    N(j-1,1:2)=[j-2+PrecPoint j+PrecPoint];
end
P3=NaN;
N(dim-2,1:2)=[dim-3+PrecPoint P2];
end

function N=neighbLine(dim,P1,P2,PrecPoint)
N=zeros(dim-2,15);
N(1,1:2)=[P1 2+PrecPoint];
for j=3:dim-2;
    N(j-1,1:2)=[j-2+PrecPoint j+PrecPoint];
end
N(dim-2,1:2)=[dim-3+PrecPoint P2];
end

function [N, NodeLink] = neibGrid(dim1,dim2,P,PrecPoint)
NodeLink=[];
N=zeros(dim1*(dim2-2),15);
for j1=1:dim1
    P1=P(j1,1);
    P2=P(j1,2);
    num=1+(dim2-2)*(j1-1);
    pos=num+PrecPoint;
    N(num,1:2)=[P1,pos+1];
    NodeLink=[NodeLink;P1,num];
    for j=3:dim2-2;
        num=j-1+(dim2-2)*(j1-1);
        pos=num+PrecPoint;
        N(num,1:2)=[pos-1, pos+1];
    end
    num=dim2-2+(dim2-2)*(j1-1);
    pos=num+PrecPoint;
    N(num,1:2)=[pos-1 P2];
    NodeLink=[NodeLink;P2,num];
end
end
function [N, NodeLink]=neighbTriangle(dim1,dim2,P1,P2,P3,PrecPoint)
NodeLink=[];
N=zeros(dim1*(dim2-1)-2,15);
T=dim2-1;
for j1=1:dim1
    switch j1
        case 1
            num=1;
            pos=num+PrecPoint;
            N(num,1:3)=[P1 pos+1,pos+T];
            NodeLink=[NodeLink;P1,num];
            for j=3:dim2-2
                num=j-1;
                pos=num+PrecPoint;
                N(num,1:3)=[pos-1 pos+1,pos+T];
            end
            num=dim2-2;
            pos=num+PrecPoint;
            N(num,1:3)=[pos-1,P3, pos+T];
            NodeLink=[NodeLink;P3,num];
         case 2
             num=1+T-1;
             pos=num+PrecPoint;
             N(num,1:3)=[ pos+1,P1,pos+T];
             NodeLink=[NodeLink;P1,num];
             for j=2:dim2-2
                 num=j+T-1;
                 pos=num+PrecPoint;
                 N(num,1:4)=[pos-1 pos+1,pos-T,pos+T];
             end
             num=dim2-1+T-1;
             pos=num+PrecPoint;
             N(num,1:4)=[pos-1,P3,pos-T, pos+T];
             NodeLink=[NodeLink;P3,num];
         case  dim1-1
             num=1+T*(j1-1)-1;
             pos=num+PrecPoint;
             N(num,1:3)=[ pos+1,pos-T,P2];
             NodeLink=[NodeLink;P2,num];
             for j=2:dim2-2
                 num=j+T*(j1-1)-1;
                 pos=num+PrecPoint;
                 N(num,1:4)=[pos-1 pos+1,pos-T,pos+T-1];
             end
             num=dim2-1+T*(j1-1)-1;
             pos=num+PrecPoint;
             N(num,1:4)=[pos-1,P3,pos-T, pos+T-1];
             NodeLink=[NodeLink;P3,num];
         case dim1
             num=1+T*(j1-1)-1;
             pos=num+PrecPoint;
             N(num,1:3)=[P2 pos+1,pos-T+1];
             NodeLink=[NodeLink;P2,num];
             for j=3:dim2-2
                 num=j-1+T*(j1-1)-1;
                 pos=num+PrecPoint;
                 N(num,1:3)=[pos-1 pos+1,pos-T+1];
             end
             num=dim2-2+T*(j1-1)-1;
             pos=num+PrecPoint;
             N(num,1:3)=[pos-1,P3, pos-T+1];
             NodeLink=[NodeLink;P3,num];
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
            NodeLink=[NodeLink;P3,num];
    end
end
end
function [N, NodeLink]=neighbQuad(dim1,dim2,P1,P2,P3,P4,PrecPoint)
NodeLink=[];
N=zeros(dim1*dim2-4,15);
 T=dim2;
        for j1=1:dim1 
            switch j1
                case 1
                    num=1;
                    pos=num+PrecPoint;
                    N(num,1:3)=[P1 pos+1,pos+T-1];
                    NodeLink=[NodeLink;P1,num];
                    for j=3:dim2-2
                        num=j-1;
                        pos=num+PrecPoint;
                        N(num,1:3)=[pos-1 pos+1,pos+T-1];
                    end
                    num=dim2-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P4, pos+T-1];
                    NodeLink=[NodeLink;P4,num];
                case 2
                    num=1+T-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,P1,pos+T];
                    NodeLink=[NodeLink;P1,num];
                    for j=2:dim2-1
                        num=j+T-2;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T+1,pos+T];
                    end
                    num=dim2+T-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P4,pos+T];
                    NodeLink=[NodeLink;P4,num];
                case  dim1-1
                    num=1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[ pos+1,pos-T,P2];
                    NodeLink=[NodeLink;P2,num];
                    for j=2:dim2-1
                        num=j+T*(j1-1)-2;
                        pos=num+PrecPoint;
                        N(num,1:4)=[pos-1 pos+1,pos-T,pos+T-1];
                    end
                    num=dim2+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,pos-T, P3];
                    NodeLink=[NodeLink;P3,num];
                    
                case dim1
                    num=1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[P2 pos+1,pos-T+1];
                    NodeLink=[NodeLink;P2,num];
                    for j=3:dim2-2
                        num=j-1+T*(j1-1)-2;
                        pos=num+PrecPoint;
                        N(num,1:3)=[pos-1 pos+1,pos-T+1];
                    end
                    num=dim2-1-1+T*(j1-1)-2;
                    pos=num+PrecPoint;
                    N(num,1:3)=[pos-1,P3, pos-T+1];
                    NodeLink=[NodeLink;P3,num];
                    
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
