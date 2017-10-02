function [X1,Y1,Z1] = cylX(P1,P2,r1)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
l=modulus(P1-P2);
fi=0:0.08*pi:2*pi;
y1=r1*cos(fi);
z1=r1*sin(fi);
x1=[P1(1) P2(1)];
Z1=ones(length(x1),length(z1))*diag(z1)+P1(3);
Y1=ones(length(x1),length(z1))*diag(y1)+P1(2);
X1=diag(x1)*ones(length(x1),length(z1));


end

