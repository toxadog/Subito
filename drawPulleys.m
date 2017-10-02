function drawPulleys(Param)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
l=6;
for i=2
% for i=1:size(Param.Pulleys,2)
    P1=[-l;Param.Pulleys(:,i)];
    P2=[l;Param.Pulleys(:,i)];
    [X1,Y1,Z1]=cylX(P1,P2,Param.PulleyR);
    surf(X1,Z1,Y1,'FaceColor','none','EdgeColor',[0.9 0.9 0.9]);
end
end

