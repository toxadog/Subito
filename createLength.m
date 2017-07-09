function L = createLength(NElements,gLines,Tendons,Length)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Neigmax=15;
load('Connect.mat');
nN=[find(NElements(:,1)==1,1, 'last');find(NElements(:,1)==2,1, 'last');find(NElements(:,1)==3,1, 'last');...
    find(NElements(:,1)==4,1, 'last');find(NElements(:,1)==5,1, 'last')];
NEl=size(NElements,1);
L=zeros(sum(NElements(:,2)),Neigmax);
counter=1;
for i=1:NEl
    PrecPoint=sum(NElements(1:i-1,2));
switch NElements(i,1)
    case 1
         L(counter:counter+NElements(i,2)-1,:)=zeros(NElements(i,2),15);
    case 2
        band=Tendons.(horzcat('n',int2str(i-nN(1))));
        dim=size(band,2);
        dl=Length.(horzcat('n',int2str(i-nN(1))))/(dim-1);
        P1=ConnectN(i-nN(1),2);
        P2=ConnectN(i-nN(1),3);
        L(P1,find(L(P1,:)==0,1,'first'))=dl;
        L(P2,find(L(P2,:)==0,1,'first'))=dl;
        L(counter:counter+NElements(i,2)-1,:)=repmat([dl,dl,zeros(1,Neigmax-2)],dim-2,1);
    case 3
        band=Tendons.(horzcat('t',int2str(i-nN(2))));
        dim=size(band,2);
        dl=Length.(horzcat('t',int2str(i-nN(2))))/(dim-1);
        P1=ConnectT(i-nN(2),2);
        P2=ConnectT(i-nN(2),3);
        L(P1,find(L(P1,:)==0,1,'first'))=dl;
        L(P2,find(L(P2,:)==0,1,'first'))=dl;
        L(counter:counter+NElements(i,2)-1,:)=repmat([dl,dl,zeros(1,Neigmax-2)],dim-2,1);
    case 4
       
        grid=Tendons.(horzcat('g',int2str(i-nN(3))));
        g=gLines.(horzcat('g',int2str(i-nN(3))));
        L1=ConnectG(i-nN(3),2);
        L2=ConnectG(i-nN(3),3);
        dim1=size(grid,3);
        dim2=size(grid,2);
        P=defineP(dim1,L1,L2,ConnectN,g,NElements,nN(1));
        NP=[size(Tendons.(horzcat('n',int2str(L1))),2),size(Tendons.(horzcat('n',int2str(L2))),2)];
        [L(counter:counter+NElements(i,2)-1,:), NodeLink]=neibGrid(dim1,dim2,NP,P,g,Length.(horzcat('g',int2str(i-nN(3)))));
        for k=1:size(NodeLink,1)
            L(NodeLink(k,1),find(L(NodeLink(k,1),:)==0,1,'first'))=NodeLink(k,2);
        end
    case 5
        grid=Tendons.(horzcat('s',int2str(i-nN(4)))); 
        dim1=size(grid,3);
        dim2=size(grid,2);
        P1=ConnectS(i-nN(4),2);
        P2=ConnectS(i-nN(4),3);
        P3=ConnectS(i-nN(4),4);
        [L(counter:counter+NElements(i,2)-1,:), NodeLink]=lengthTriangle(dim1,dim2,P1,P2,P3,Length.(horzcat('s',int2str(i-nN(4)))));
        for k=1:size(NodeLink,1)
            L(NodeLink(k,1),find(L(NodeLink(k,1),:)==0,1,'first'))=NodeLink(k,2);
        end
    case 6
        grid=Tendons.(horzcat('m',int2str(i-nN(5)))); 
        dim1=size(grid,3);
        dim2=size(grid,2);
        P1=ConnectM(i-nN(5),2);
        P2=ConnectM(i-nN(5),3);
        P3=ConnectM(i-nN(5),4);
        P4=ConnectM(i-nN(5),5);
        [L(counter:counter+NElements(i,2)-1,:), NodeLink]=lengthQuad(dim1,dim2,P1,P2,P3,P4,Length.(horzcat('m',int2str(i-nN(5)))));
        for k=1:size(NodeLink,1)
            L(NodeLink(k,1),find(L(NodeLink(k,1),:)==0,1,'first'))=NodeLink(k,2);
        end
end
counter=counter+NElements(i,2);
end
end



function [L, NodeLink] = neibGrid(dim1,dim2,NP,P,g,Length)
NodeLink=[];
L=zeros(dim1*(dim2-2),15);
dl1=sqrt(Length(1)^2+(Length(2)*(NP(1)-g(1,1))/(NP(1)-1)-Length(3)*(NP(2)-g(2,1))/(NP(2)-1))^2)/(dim2-1);
dl2=sqrt(Length(1)^2+(Length(3)*(NP(2)-g(2,1))/(NP(2)-1)-Length(3)*(NP(2)-g(2,size(g,2)))/(NP(2)-1))^2)/(dim2-1);
dl=linspace(dl1,dl2,dim1);
for j1=1:dim1
    P1=P(j1,1);
    P2=P(j1,2);
    num=1+(dim2-2)*(j1-1);
    L(num,1:2)=[dl(j1),dl(j1)];
    NodeLink=[NodeLink;P1,dl(j1)];
    for j=3:dim2-2;
        num=j-1+(dim2-2)*(j1-1);
        L(num,1:2)=[dl(j1),dl(j1)];
    end
    num=dim2-2+(dim2-2)*(j1-1);
    L(num,1:2)=[dl(j1), dl(j1)];
    NodeLink=[NodeLink;P2,dl(j1)];
end
end
function [L, NodeLink]=lengthTriangle(dim1,dim2,P1,P2,P3,Length)
NodeLink=[];
L=zeros(dim1*(dim2-1)-2,15);
T=dim2-1;
dlh=linspace(Length(1)/(dim1-1), 0,dim2);
dlv=linspace(Length(2)/(dim2-1), Length(3)/(dim2-1),dim1);
for j1=1:dim1
    switch j1
        case 1
            for j=2:dim2-1  
                num=j-1;
                L(num,1:3)=[dlv(1), dlv(1), dlh(j)];
            end
            NodeLink=[NodeLink;P1,dlv(1)];
            NodeLink=[NodeLink;P3,dlv(1)];
         case 2
             num=1+T-1;
             L(num,1:3)=[dlv(2),dlh(1),dlh(1)];
             for j=2:dim2-2
                 num=j+T-1;
                 L(num,1:4)=[dlv(2) dlv(2),dlh(j),dlh(j)];
             end
             num=dim2-1+T-1;
             L(num,1:4)=[dlv(2),dlv(2),dlh(dim2-1),dlh(dim2-1)];
             NodeLink=[NodeLink;P1,dlh(1)];
             NodeLink=[NodeLink;P3,dlv(2)];    
          case  dim1-1
              num=1+T*(j1-1)-1;
              L(num,1:3)=[dlv(dim1-1),dlh(1),dlh(1)];
              for j=2:dim2-2
                  num=j+T*(j1-1)-1;
                  L(num,1:4)=[dlv(dim1-1) dlv(dim1-1),dlh(j) dlh(j)];
              end
              num=dim2-1+T*(j1-1)-1;
              L(num,1:4)=[dlv(dim1-1),dlv(dim1-1),dlh(dim2-1),dlh(dim2-1)];
              NodeLink=[NodeLink;P2,dlh(1)];
              NodeLink=[NodeLink;P3,dlv(dim1-1)]; 
                    
          case dim1
              for j=2:dim2-1
                  num=j-1+T*(j1-1)-1;
                  L(num,1:3)=[dlv(dim1) dlv(dim1),dlh(j)];
              end
              NodeLink=[NodeLink;P2,dlv(dim1)];
              NodeLink=[NodeLink;P3,dlv(dim1)];
        otherwise
            num=1+T*(j1-1)-1;
            L(num,1:3)=[dlv(j1),dlh(1),dlh(1)];
            for j=2:dim2-2
                num=j+T*(j1-1)-1;
                L(num,1:4)=[dlv(j1) dlv(j1),dlh(j),dlh(j)];
            end
            num=dim2-1+T*(j1-1)-1;
            L(num,1:4)=[dlv(j1),dlv(j1),dlh(dim2-1),dlh(dim2-1)];
            NodeLink=[NodeLink;P3,dlv(j1)];
    end
end
end
function [L, NodeLink]=lengthQuad(dim1,dim2,P1,P2,P3,P4,Length)
NodeLink=[];
L=zeros(dim1*dim2-4,15);
T=dim2;
dlh=linspace(Length(2)/(dim1-1), Length(1)/(dim1-1),dim2);
dlv=linspace(Length(3)/(dim2-1), Length(4)/(dim2-1),dim1);
        for j1=1:dim1 
            switch j1
                case 1
                    for j=2:dim2-1
                        num=j-1;
                        L(num,1:3)=[dlv(1), dlv(1), dlh(j)];
                    end
                    NodeLink=[NodeLink;P1,dlv(1)];
                    NodeLink=[NodeLink;P4,dlv(1)];
                case 2
                    num=1+T-2;
                    L(num,1:3)=[dlv(2),dlh(1),dlh(1)];
                     for j=2:dim2-1
                        num=j+T-2;
                        L(num,1:4)=[dlv(2) dlv(2),dlh(j),dlh(j)];
                     end
                    num=dim2+T-2;
                    L(num,1:3)=[dlv(2),dlh(dim2),dlh(dim2)];
                    NodeLink=[NodeLink;P1,dlh(1)];
                    NodeLink=[NodeLink;P4,dlh(dim2)];    
                case  dim1-1
                    num=1+T*(j1-1)-2;
                    L(num,1:3)=[dlv(dim1-1),dlh(1),dlh(1)];
                    for j=2:dim2-1
                        num=j+T*(j1-1)-2;
                        L(num,1:4)=[dlv(dim1-1) dlv(dim1-1),dlh(j) dlh(j)];
                    end
                    num=dim2+T*(j1-1)-2;
                    L(num,1:3)=[dlv(dim1-1),dlh(dim2),dlh(dim2)];
                    NodeLink=[NodeLink;P2,dlh(1)];
                    NodeLink=[NodeLink;P3,dlh(dim2)]; 
                    
                case dim1
                    for j=2:dim2-1
                        num=j-1+T*(j1-1)-2;
                        L(num,1:3)=[dlv(dim1) dlv(dim1),dlh(j)];
                    end
                    NodeLink=[NodeLink;P2,dlv(dim1)];
                    NodeLink=[NodeLink;P3,dlv(dim1)];
                otherwise
                    num=1+T*(j1-1)-2;
                    L(num,1:3)=[dlv(j1),dlh(1),dlh(1)];
                    for j=2:dim2-1
                        num=j+T*(j1-1)-2;
                        L(num,1:4)=[dlv(j1) dlv(j1),dlh(j),dlh(j)];
                    end
                    num=dim2+T*(j1-1)-2;
                    L(num,1:3)=[dlv(j1),dlh(dim2),dlh(dim2)];  
            end
        end 
end

