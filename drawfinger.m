function [] = drawfinger(bonepoints)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global haxes hand
r1=hand(5);
r2=hand(6);
r3=hand(7);
r4=hand(8);
R1=hand(9);
R2=hand(10);
R3=hand(11);
P1=bonepoints(:,1);
P2=bonepoints(:,2);
P3=bonepoints(:,3);
P4=bonepoints(:,4);
P5=bonepoints(:,5);
axes(haxes);
cla;
[X1,Y1,Z1]=cyl(P1,P2,r4);
surf(haxes,X1,Z1,Y1,'FaceColor','none','EdgeColor',[0.7 0.7 0.7]);
hold on

[X1,Y1,Z1]=sph(P2, R3);
surf(haxes,X1,Z1,Y1,'FaceColor','none','EdgeColor',[0.7 0.7 0.7]);

[X1,Y1,Z1]=cyl(P2,P3,r3);
surf(haxes,X1,Z1,Y1,'FaceColor','none','EdgeColor',[0.7 0.7 0.7]);

[X1,Y1,Z1]=sph(P3, R2);
surf(haxes,X1,Z1,Y1,'FaceColor','none','EdgeColor',[0.7 0.7 0.7]);


[X1,Y1,Z1]=cyl(P3,P4,r2);
surf(haxes,X1,Z1,Y1,'FaceColor','none','EdgeColor',[0.7 0.7 0.7]);

[X1,Y1,Z1]=sph(P4, R1);
surf(haxes,X1,Z1,Y1,'FaceColor','none','EdgeColor',[0.7 0.7 0.7]);


[X1,Y1,Z1]=cyl(P4,P5,r1);
surf(haxes,X1,Z1,Y1,'FaceColor','none','EdgeColor',[0.7 0.7 0.7]);

set(haxes,'XLimMode','manual','XTick',[],'XTickLabel',[],'YLimMode','manual','YTick',[],'YTickLabel',[],'ZLimMode','manual','ZTick',[],'ZTickLabel',[],'ZLim',[-80 80 ],'XLim',[-80 80 ],'YLim',[0 160 ]);
end
