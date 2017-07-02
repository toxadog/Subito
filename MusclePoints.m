function [M1,M2,M3,M4,PulleyM1,PulleyM3,PulleyM4] = MusclePoints(Param)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
hand=Param.hand;
l4=hand(4);
r4=hand(8);

z0=l4/2;
zPulley=0.9*l4;
M1=[1.4*r4*sin(103*pi/180);1.4*r4*cos(103*pi/180);z0];
M2=[0;1.1*r4;z0];
M3=[1.4*r4*sin(-100*pi/180);1.4*r4*cos(-100*pi/180);z0];
M4=[1.4*r4*sin(-134*pi/180);1.4*r4*cos(-134*pi/180);z0];
PulleyM1=[1.4*r4*sin(130*pi/180);1.4*r4*cos(130*pi/180);zPulley];
PulleyM3=[1.4*r4*sin(-130*pi/180);1.4*r4*cos(-130*pi/180);zPulley];
PulleyM4=[1.4*r4*sin(-160*pi/180);1.4*r4*cos(-160*pi/180);zPulley];
end

