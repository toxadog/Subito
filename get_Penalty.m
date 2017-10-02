function Penalty = get_Penalty(NElements)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Penalty=zeros(sum(NElements(:,2)),1);
for i=[5 9 12 16 21 27]
    Penalty(sum(NElements(1:i-1,2))+1:sum(NElements(1:i,2)))=ones;
end
for i=[35 36]
    Penalty(sum(NElements(1:i-1,2))+1:sum(NElements(1:i-1,2))+14)=ones;
end

end


