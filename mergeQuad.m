function [Points,Neighbours,Length,NElements] = mergeQuad(Points,Neighbours,Length,NElements,Q1,Q2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ElType=6;
load('Connect.mat')
dim1=NElements(Q1,4);
dim2=NElements(Q1,3);
if NElements(Q1,4)~=NElements(Q2,4)
    display('Fail to merge: element dimentions missmatch');
    return;
end
pos1=[1:dim2-2]+sum(NElements(1:Q1-1,2));
% pos2=[1+(dim1-1)*dim2-2:dim2-2+(dim1-1)*dim2-2]+sum(NElements(1:Q2-1,2));
pos2=[1:dim2-2]+sum(NElements(1:Q2-1,2));
Neighbours(pos2,4) = Neighbours(pos1,3);
Length(pos2,4) = Length(pos1,3); 
Neighbours(Neighbours(pos1,3),3)=pos2;
nN=[find(NElements(:,1)==1,1, 'last');find(NElements(:,1)==2,1, 'last');find(NElements(:,1)==3,1, 'last');...
find(NElements(:,1)==4,1, 'last');find(NElements(:,1)==5,1, 'last')];
Node1=(ConnectM(Q1-nN(ElType-1),2));
Node2=(ConnectM(Q1-nN(ElType-1),5));
Neighbours=deletelink(Neighbours,Node1,pos1(1));
Neighbours=deletelink(Neighbours,Node2,pos1(dim2-2));
Neighbours(pos1,:)=zeros;
Length=deletelink(Length,Node1,pos1(1));
Length=deletelink(Length,Node2,pos1(dim2-2));
Length(pos1,:)=zeros;
Points(pos1,:)=NaN;
NElements(Q2,2:4)=[(dim1*2-1)*dim2-6 dim2 dim1*2-1];
NElements(Q1:size(NElements,1)-1,2:4)=NElements(Q1+1:size(NElements,1),2:4);
NElements=NElements(1:size(NElements,1)-1,:);
end
function Neighbours=deletelink(Neighbours,Node,el)
pos1Node=find(Neighbours(Node,:)==el);
pos2Node=find(Neighbours(Node,:)==0,1,'first');
Neighbours(Node,pos1Node:pos2Node-2)=Neighbours(Node,pos1Node+1:pos2Node-1);
Neighbours(Node,pos2Node-1)=0;
end