function [l,ncoord] = calcL(dl,l,n,L)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if l-dl>=0
    l=l-dl;
    ncoord=n;
else
    if n>1
        [l,ncoord] = calcL(dl-l,L(n-1),n-1,L);
    else
        l=l-dl;
        ncoord=n;
    end
end 

end

