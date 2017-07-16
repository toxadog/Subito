function drawforces(Points, Forces)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
cylr=0.5;
t = 0:cylr/10:cylr;
[Xcyl,Ycyl,Zcyl] = cylinder(t);
Xcyl2=zeros(size(Xcyl));
Ycyl2=zeros(size(Ycyl));
Zcyl2=zeros(size(Zcyl));
for i=1:size(Forces,1)
    if modulus(Forces(i,:))~=0
        F=Forces(i,:)*5;
        angles=[pi-atan2(Forces(i,2),Forces(i,3));...
            -sign(Forces(i,1))*acos(modulus(Forces(i,2:3))/modulus(Forces(i,:)))];
%         if Forces(i,2)<0
%             angles(2)=-sign(Forces(i,1))*(acos(modulus(Forces(i,2:3))/modulus(Forces(i,:))));
%         end
        line([Points(i,1) Points(i,1)+F(1)],...
            [Points(i,3) Points(i,3)+F(3)],...
            [Points(i,2) Points(i,2)+F(2)],'Color',[225,156,118]/255,'LineWidth',2);
        for c1=1:size(Xcyl,1)
            for c2=1:size(Xcyl,2)
                P=[Xcyl(c1,c2);Ycyl(c1,c2);Zcyl(c1,c2)];
                M1=[1 0 0;0 cos(angles(1)) -sin(angles(1)); 0 sin(angles(1)) cos(angles(1))];
                M2=[cos(angles(2)) 0 sin(angles(2));0 1 0; -sin(angles(2)) 0 cos(angles(2))];
                M3=[cos(angles(2)) -sin(angles(2)) 0;sin(angles(2)) cos(angles(2)) 0;0 0 1];

                P=M1*M2*P;
                Xcyl2(c1,c2)=P(1)+Points(i,1)+F(1);
                Ycyl2(c1,c2)=P(2)+Points(i,2)+F(2);
                Zcyl2(c1,c2)=P(3)+Points(i,3)+F(3);
            end
        end
        surf(Xcyl2,Zcyl2,Ycyl2,'FaceColor',[165,65,10]/255,'EdgeColor',[165,65,10]/255)
    end
end
end

