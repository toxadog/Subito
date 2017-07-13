function [Tendons,ColorStr,ForcesStr] = imergeQuad(Tendons,ColorStr,ForcesStr)
%UNTITLED Summary of this function goes here
% temporary code to demerge two membranes

Tendons.m1(:,:,1)=Tendons.m2(:,:,1);
ColorStr.m1(1,:)=ColorStr.m2(1,:);
ForcesStr.m1(1,:)=ForcesStr.m2(1,:);
end

