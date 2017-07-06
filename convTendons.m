function [TendonsConv, Neighbours] = convTendons(Tendons, Nodes, gLines)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
NElType=6;
load('Connect.mat');
names=fieldnames(Tendons);
NElements=repmat([1,1],size(Nodes,2),1);
for i=1:size(names,1);
    ElName=char(names(i,:));
    switch ElName(1)
        case 'n'
            NElements(size(Nodes,2)+i,:)=[2 size(Tendons.(ElName),2)-2];
        case 't'
            NElements(size(Nodes,2)+i,:)=[3 size(Tendons.(ElName),2)-2];
        case 'g'
            NElements(size(Nodes,2)+i,:)=[4 size(Tendons.(ElName),2)*size(Tendons.(ElName),3)-2*size(Tendons.(ElName),3)];
        case 's'
            NElements(size(Nodes,2)+i,:)=[5 size(Tendons.(ElName),2)*size(Tendons.(ElName),3)-2-size(Tendons.(ElName),3)];    
        case 'm'
            NElements(size(Nodes,2)+i,:)=[6 size(Tendons.(ElName),2)*size(Tendons.(ElName),3)-4];    
    end
end 
NPoints=sum(NElements(:,2));
NEl=size(NElements,1);
counter=1;
TendonsConv=zeros(NPoints,3);
Neighbours=zeros(NPoints,15);
for i=1:NEl
    T=convertElement(i,NElements,Nodes,Tendons);
    N=get_Neighbors(i,NElements,Nodes,gLines,Tendons);

    TendonsConv(counter:counter+NElements(i,2)-1,:)=T;
    Neighbours(counter:counter+NElements(i,2)-1,:)=N;
    counter=counter+NElements(i,2);
end
end

