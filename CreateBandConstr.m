function points = CreateBandConstr(P1,P2,PConstr,Param,npoints)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
points=CreateBand(P1,P2,npoints);
v1=[0;1;1].*(P1-P2);
v2=[0;1;1].*(P1-PConstr);
angle = cross(v1/modulus(v1),v2/modulus(v2));
PulleyR = Param.PulleyR;
M= point2line(PConstr,P1,P2);
n=(PConstr-M)/modulus(PConstr-M);
PConstr=PConstr+[0;1;1].*n*PulleyR;
if angle(1)>=0
     M= point2line(PConstr,P1,P2);
     n=(PConstr-M)/modulus(PConstr-M);
     Dx1=modulus(M-P1);
     Dx2=modulus(M-P2);
     Dy=modulus(M-PConstr);
     for i=2:npoints-1
         dx1=modulus(points(:,i)-P1);
         dx2=modulus(points(:,i)-P2);
         if dx1<Dx1
             dx=dx1;
             Dx=Dx1;
         else
             dx=dx2;
             Dx=Dx2;
         end
         points(:,i)=points(:,i)+n*Dy*dx/Dx;
     end
         
end
% d=(P2-P1)/(npoints-1);
% points=zeros(3,npoints);
% points(:,1)=P1;
% for i=2:npoints
%     points(:,i)=points(:,i-1)+d;
% end
end

