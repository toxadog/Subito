function [TendonsConv, Neighbours, Map,NElements] = convTendons(Tendons, Nodes, gLines)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
load('Connect.mat');
names=fieldnames(Tendons);
NElements=repmat([1,1,0,0],size(Nodes,2),1);
for i=1:size(names,1);
    ElName=char(names(i,:));
    switch ElName(1)
        case 'n'
            NElements(size(Nodes,2)+i,1:2)=[2 size(Tendons.(ElName),2)-2];
        case 't'
            NElements(size(Nodes,2)+i,1:2)=[3 size(Tendons.(ElName),2)-2];
        case 'g'
            NElements(size(Nodes,2)+i,1:4)=[4 size(Tendons.(ElName),2)*size(Tendons.(ElName),3)-2*size(Tendons.(ElName),3),size(Tendons.(ElName),2),size(Tendons.(ElName),3)];
        case 's'
            NElements(size(Nodes,2)+i,1:4)=[5 size(Tendons.(ElName),2)*size(Tendons.(ElName),3)-2-size(Tendons.(ElName),3),size(Tendons.(ElName),2),size(Tendons.(ElName),3)];    
        case 'm'
            NElements(size(Nodes,2)+i,1:4)=[6 size(Tendons.(ElName),2)*size(Tendons.(ElName),3)-4,size(Tendons.(ElName),2),size(Tendons.(ElName),3)];    
    end
end 
NPoints=sum(NElements(:,2));
NEl=size(NElements,1);
counter=1;
TendonsConv=zeros(NPoints,3);
nN=zeros(5,1);
for i=1:5
    nelem=find(NElements(:,1)==i,1, 'last');
    if ~isempty(nelem)
        nN(i)=nelem;
    else
        nN(i)=nN(i-1);
    end
end
for i=1:NEl
    T=convertElement(i,NElements,Nodes,Tendons);
    TendonsConv(counter:counter+NElements(i,2)-1,:)=T;
    switch NElements(i,1)
        case 2
            Map.(horzcat('n',int2str(i-nN(1))))=NumBand(ConnectN(i-nN(1),2),ConnectN(i-nN(1),3),size(Tendons.(horzcat('n',int2str(i-nN(1)))),2),counter);
        case 3
            Map.(horzcat('t',int2str(i-nN(2))))=NumBand(ConnectT(i-nN(2),2),ConnectT(i-nN(2),3),size(Tendons.(horzcat('t',int2str(i-nN(2)))),2),counter);
        case 4
            g=gLines.(horzcat('g',int2str(i-nN(3))));
            L1=ConnectG(i-nN(3),2);
            L2=ConnectG(i-nN(3),3);
            dim1=size(Tendons.(horzcat('g',int2str(i-nN(3)))),3);
            dim2=size(Tendons.(horzcat('g',int2str(i-nN(3)))),2);
            P=defineP(dim1,L1,L2,ConnectN,g,NElements,nN(1));
            Map.(horzcat('g',int2str(i-nN(3))))=NumGrid(P,dim2,counter);
        case 5
            dim1=size(Tendons.(horzcat('s',int2str(i-nN(4)))),3);
            dim2=size(Tendons.(horzcat('s',int2str(i-nN(4)))),2);
            Map.(horzcat('s',int2str(i-nN(4))))=NumTriang(ConnectS(i-nN(4),2),ConnectS(i-nN(4),3),ConnectS(i-nN(4),4),dim1,dim2,counter);
        case 6
            dim1=size(Tendons.(horzcat('m',int2str(i-nN(5)))),3);
            dim2=size(Tendons.(horzcat('m',int2str(i-nN(5)))),2);
            Map.(horzcat('m',int2str(i-nN(5))))=NumQuad(ConnectM(i-nN(5),2),ConnectM(i-nN(5),3),ConnectM(i-nN(5),4),ConnectM(i-nN(5),5),dim1,dim2,counter);
    end
    counter=counter+NElements(i,2);
end
Neighbours=get_Neighbors(NElements,gLines,Tendons);

end

