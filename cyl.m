function [X1,Y1,Z1] = cyl(P1,P2,r1)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
l=modulus(P1-P2);
fi=0:0.08*pi:2*pi;
y1=r1*cos(fi);
x1=r1*sin(fi);
z1=[0 l];
if (atan((P2(2)-P1(2))/(P2(3)-P1(3)))==0)&&(P2(3)-P1(3)>0)
X1=ones(length(z1),length(x1))*diag(x1)+P1(1);
Y1=ones(length(z1),length(x1))*diag(y1)+P1(2);
Z1=diag(z1)*ones(length(z1),length(x1))+P1(3);
else
    
    if P2(3)-P1(3)>=0
       angx=atan((P2(2)-P1(2))/(P2(3)-P1(3)));
   else
       angx=atan((P2(2)-P1(2))/(P2(3)-P1(3)))+pi;
   end
   
    X1=ones(length(z1),length(x1));
    Z1=ones(length(z1),length(x1));
    Y1=ones(length(z1),length(x1));
for i=1:length(z1)
for j=1:length(x1)
    
    
    
    Point=ROTx3(-angx)*[x1(j);y1(j);z1(i)]+P1;
    X1(i,j)=Point(1);
    Y1(i,j)=Point(2);
    Z1(i,j)=Point(3);
end
end


end
end

