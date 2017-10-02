function K = createStiffness(NElements,gLines,Tendons)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Neigmax=15;
k1=173000;
load('Connect.mat');
nN=zeros(5,1);
for i=1:5
    nelem=find(NElements(:,1)==i,1, 'last');
    if ~isempty(nelem)
        nN(i)=nelem;
    else
        nN(i)=nN(i-1);
    end
end
NEl=size(NElements,1);
K=zeros(sum(NElements(:,2)),Neigmax);
counter=1;
for i=1:NEl
    PrecPoint=sum(NElements(1:i-1,2));
switch NElements(i,1)
    case 1
         K(counter:counter+NElements(i,2)-1,:)=zeros(NElements(i,2),15);
    case 2
        band=Tendons.(horzcat('n',int2str(i-nN(1))));
        dim=size(band,2);
        P1=ConnectN(i-nN(1),2);
        P2=ConnectN(i-nN(1),3);
        K(P1,find(K(P1,:)==0,1,'first'))=k1/2;
        K(P2,find(K(P2,:)==0,1,'first'))=k1/2;
        K(counter:counter+NElements(i,2)-1,:)=repmat([k1/2,k1/2,zeros(1,Neigmax-2)],dim-2,1);
    case 3
        band=Tendons.(horzcat('t',int2str(i-nN(2))));
        dim=size(band,2);
        P1=ConnectT(i-nN(2),2);
        P2=ConnectT(i-nN(2),3);
        K(P1,find(K(P1,:)==0,1,'first'))=k1/2;
        K(P2,find(K(P2,:)==0,1,'first'))=k1/2;
        K(counter:counter+NElements(i,2)-1,:)=repmat([k1/2,k1/2,zeros(1,Neigmax-2)],dim-2,1);
    case 4  
        grid=Tendons.(horzcat('g',int2str(i-nN(3))));
        g=gLines.(horzcat('g',int2str(i-nN(3))));% array of boundary point numbers
        L1=ConnectG(i-nN(3),2);% number of the first framing band
        L2=ConnectG(i-nN(3),3);% number of the second framing band
        dim1=size(grid,3);
        dim2=size(grid,2);
        P=defineP(dim1,L1,L2,ConnectN,g,NElements,nN(1));
        [K(counter:counter+NElements(i,2)-1,:), NodeLink]=stiffGrid(dim1,dim2,k1/100,P);
        for k=1:size(NodeLink,1)
            K(NodeLink(k,1),find(K(NodeLink(k,1),:)==0,1,'first'))=NodeLink(k,2);
        end
    case 5
        grid=Tendons.(horzcat('s',int2str(i-nN(4)))); 
        dim1=size(grid,3);
        dim2=size(grid,2);
        P1=ConnectS(i-nN(4),2);
        P2=ConnectS(i-nN(4),3);
        P3=ConnectS(i-nN(4),4);
        [K(counter:counter+NElements(i,2)-1,:), NodeLink]=stiffTriangle(dim1,dim2,P1,P2,P3,k1/2,k1/100);
        for k=1:size(NodeLink,1)
            K(NodeLink(k,1),find(K(NodeLink(k,1),:)==0,1,'first'))=NodeLink(k,2);
        end
    case 6
        grid=Tendons.(horzcat('m',int2str(i-nN(5)))); 
        dim1=size(grid,3);
        dim2=size(grid,2);
        P1=ConnectM(i-nN(5),2);
        P2=ConnectM(i-nN(5),3);
        P3=ConnectM(i-nN(5),4);
        P4=ConnectM(i-nN(5),5);
        [K(counter:counter+NElements(i,2)-1,:), NodeLink]=stiffQuad(dim1,dim2,P1,P2,P3,P4,k1/100,k1/100);
        for k=1:size(NodeLink,1)
            K(NodeLink(k,1),find(K(NodeLink(k,1),:)==0,1,'first'))=NodeLink(k,2);
        end
end
counter=counter+NElements(i,2);
end
end



function [L, NodeLink] = stiffGrid(dim1,dim2,k,P)
NodeLink=[];
L=zeros(dim1*(dim2-2),15);
for j1=1:dim1
    P1=P(j1,1);
    P2=P(j1,2);
    num=1+(dim2-2)*(j1-1);
    L(num,1:2)=[k,k];
    NodeLink=[NodeLink;P1,k];
    for j=3:dim2-2;
        num=j-1+(dim2-2)*(j1-1);
        L(num,1:2)=[k,k];
    end
    num=dim2-2+(dim2-2)*(j1-1);
    L(num,1:2)=[k,k];
    NodeLink=[NodeLink;P2,k];
end
end

function [K, NodeLink]=stiffTriangle(dim1,dim2,P1,P2,P3,k,k2)
NodeLink=[];
K=zeros(dim1*(dim2-1)-2,15);
T=dim2-1;
for j1=1:dim1
    switch j1
        case 1
            for j=2:dim2-1  
                num=j-1;
                K(num,1:3)=[k, k, k2];
            end
            NodeLink=[NodeLink;P1,k];
            NodeLink=[NodeLink;P3,k];
         case 2
             num=1+T-1;
             K(num,1:3)=[k2, k2, k2];
             for j=2:dim2-2
                 num=j+T-1;
                 K(num,1:4)=[k2, k2, k2, k2];
             end
             num=dim2-1+T-1;
             K(num,1:4)=[k2, k2, k2, k2];
             NodeLink=[NodeLink;P1,k2];
             NodeLink=[NodeLink;P3,k2];    
          case  dim1-1
              num=1+T*(j1-1)-1;
              K(num,1:3)=[k2, k2, k2];
              for j=2:dim2-2
                  num=j+T*(j1-1)-1;
                  K(num,1:4)=[k2, k2, k2, k2];
              end
              num=dim2-1+T*(j1-1)-1;
              K(num,1:4)=[k2, k2, k2, k2];
              NodeLink=[NodeLink;P2,k2];
              NodeLink=[NodeLink;P3,k2]; 
                    
          case dim1
              for j=2:dim2-1
                  num=j-1+T*(j1-1)-1;
                  K(num,1:3)=[k, k, k2];
              end
              NodeLink=[NodeLink;P2,k];
              NodeLink=[NodeLink;P3,k];
        otherwise
            num=1+T*(j1-1)-1;
            K(num,1:3)=[k2, k2, k2];
            for j=2:dim2-2
                num=j+T*(j1-1)-1;
                K(num,1:4)=[k2, k2, k2, k2];
            end
            num=dim2-1+T*(j1-1)-1;
            K(num,1:4)=[k2, k2, k2, k2];
            NodeLink=[NodeLink;P3,k2];
    end
end
end
function [K, NodeLink]=stiffQuad(dim1,dim2,P1,P2,P3,P4,k,k2)
NodeLink=[];
K=zeros(dim1*dim2-4,15);
T=dim2;
        for j1=1:dim1 
            switch j1
                case 1
                    for j=2:dim2-1
                        num=j-1;
                        K(num,1:3)=[k, k, k2];
                    end
                    NodeLink=[NodeLink;P1,k];
                    NodeLink=[NodeLink;P4,k];
                case 2
                    num=1+T-2;
                    K(num,1:3)=[k2, k, k];
                     for j=2:dim2-1
                        num=j+T-2;
                        K(num,1:4)=[k2, k2, k2, k2];
                     end
                    num=dim2+T-2;
                    K(num,1:3)=[k2, k, k];
                    NodeLink=[NodeLink;P1,k];
                    NodeLink=[NodeLink;P4,k];    
                case  dim1-1
                    num=1+T*(j1-1)-2;
                    K(num,1:3)=[k2, k, k];
                    for j=2:dim2-1
                        num=j+T*(j1-1)-2;
                        K(num,1:4)=[k2, k2, k2, k2];
                    end
                    num=dim2+T*(j1-1)-2;
                    K(num,1:3)=[k2, k, k];
                    NodeLink=[NodeLink;P2,k];
                    NodeLink=[NodeLink;P3,k]; 
                    
                case dim1
                    for j=2:dim2-1
                        num=j-1+T*(j1-1)-2;
                        K(num,1:3)=[k, k, k2];
                    end
                    NodeLink=[NodeLink;P2,k];
                    NodeLink=[NodeLink;P3,k];
                otherwise
                    num=1+T*(j1-1)-2;
                    K(num,1:3)=[k2, k, k];
                    for j=2:dim2-1
                        num=j+T*(j1-1)-2;
                        K(num,1:4)=[k2, k2, k2, k2];
                    end
                    num=dim2+T*(j1-1)-2;
                    K(num,1:3)=[k2, k, k];  
            end
        end 
end

