function Grid = NumGrid(P,dim2,pos1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:size(P,1)
    Grid(:,:,i)=NumBand(P(i,1),P(i,2),dim2,pos1);
    pos1=pos1+dim2-2;
end


end

