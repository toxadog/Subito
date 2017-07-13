NTest=zeros(size(Neighbours));
NNeigmax=size(Neighbours,2);
for i=1:size(Neighbours,1)
pos0=find(Neighbours(i,:)==0);
if isempty(pos0)
    NNeig=NNeigmax;
else
    NNeig=pos0(1)-1;
end
if NNeig~=0
    for j=1:NNeig
        pos1=find(Neighbours(Neighbours(i,j),:)==i);
        if isempty(pos1)
            NTest(i,j)=2;
        else
            NTest(i,j)=1;
        end
    end
end
end
%%
NTest=zeros(size(Neighbours));
NNeigmax=size(Neighbours,2);
for i=1:size(Neighbours,1)
pos0=find(Neighbours(i,:)==0);
if isempty(pos0)
    NNeig=NNeigmax;
else
    NNeig=pos0(1)-1;
end
if NNeig~=0
    for j=1:NNeig
        pos1=find(Neighbours(Neighbours(i,j),:)==i);
        if L(i,j)~=L(Neighbours(i,j),pos1)
            NTest(i,j)=2;
        else
            NTest(i,j)=1;
        end
    end
end
end