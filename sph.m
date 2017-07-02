function [X1,Y1,Z1] = sph(P1,R )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here


c1=1;
c2=1;
for fi=0:0.08*pi:2*pi;
for psi=0:0.08*pi:2*pi;

X1(c1,c2)=P1(1)+R*sin(psi)*cos(fi);
Y1(c1,c2)=P1(2)+R*sin(psi)*sin(fi);
Z1(c1,c2)=P1(3)+R*cos(psi);
c1=c1+1;
end
c1=1;
c2=c2+1;
end
end

