function [TendonsConv, Neighbours] = convTendons(Tendons, Nodes, gLines)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
NElType=6;
load('Connect.mat');
names=fieldnames(Tendons);
NElements=repmat([1,1],size(Nodes,2),1);
for i=1:size(names,1);
    ElName=char(names(i,:));
    switch ElName(1)
        case 'n'
            NElements(size(Nodes,2)+i,:)=[2 size(Tendons.(ElName),2)-2];
        case 't'
            NElements(size(Nodes,2)+i,:)=[3 size(Tendons.(ElName),2)-2];
        case 'g'
            NElements(size(Nodes,2)+i,:)=[4 size(Tendons.(ElName),2)*size(Tendons.(ElName),3)-2*size(Tendons.(ElName),3)];
        case 's'
            NElements(size(Nodes,2)+i,:)=[5 size(Tendons.(ElName),2)*size(Tendons.(ElName),3)-2-size(Tendons.(ElName),3)];    
        case 'm'
            NElements(size(Nodes,2)+i,:)=[6 size(Tendons.(ElName),2)*size(Tendons.(ElName),3)-4];    
    end
end 
NPoints=sum(NElements(:,2));
NEl=size(NElements,1);
counter=1;
TendonsConv=zeros(NPoints,3);
Neighbours=zeros(NPoints,15);
for i=1:NEl
    [T,N]=convertElement(i,NElements,Nodes,Tendons);
    TendonsConv(counter:counter+NElements(i,2)-1,:)=T;
    Neighbours(counter:counter+NElements(i,2)-1,:)=N;
    counter=counter+NElements(i,2);
end

% TendonsConv=[];
% 
% 
%         % Point P1
%         band=Tendons.t1';
%         TendonsConv=[TendonsConv;band(1,1:3)];
%         Map(counter,1).bands.t1=1;
%         PointsNumber.t1(1)=counter;
%         counter=counter+1;
%         % Point P2
%         band=Tendons.t6';
%         TendonsConv=[TendonsConv;band(1,1:3)];
%         Map(counter,1).bands.t6=1;
%         PointsNumber.t6(1)=counter;
%         counter=counter+1;
%         % Point P3u
%         band=Tendons.t15u';
%         TendonsConv=[TendonsConv;band(size(band,1),1:3)];
%         Map(counter,1).bands.t15u=size(band,1);
%         PointsNumber.t15u(size(band,1))=counter;
%         counter=counter+1;
%         % Point P3r
%         band=Tendons.t15r';
%         TendonsConv=[TendonsConv;band(size(band,1),1:3)];
%         Map(counter,1).bands.t15r=size(band,1);
%         PointsNumber.t15r(size(band,1))=counter;
%         counter=counter+1;
%         % Point A
% %         A=band(1:3,1);
%         band=Tendons.t2u';
%         TendonsConv=[TendonsConv;band(1,1:3)];
%         Map(counter,1).bands.t2u=1;
%         Map(counter,1).bands.t1=size(Tendons.('t1'),2);
%         Map(counter,1).bands.t2r=1;      
%         PointsNumber.t2u(1)=counter;
%         PointsNumber.t1(size(Tendons.('t1'),2))=counter;
%         PointsNumber.t2r(1)=counter;
%         counter=counter+1;
%         % Point Hu
% %         Hu=band(1:3,1);
%         band=Tendons.t3u';
%         TendonsConv=[TendonsConv;band(1,1:3)];
%         Map(counter,1).bands.t3u=1;
%         Map(counter,1).bands.t2u=size(Tendons.('t2u'),2);
%         Map(counter,1).bands.t9=size(Tendons.('t9'),2);
%         Map(counter,1).bands.t15u=1;
%         PointsNumber.t3u(1)=counter;
%         PointsNumber.t2u(size(Tendons.('t2u'),2))=counter;
%         PointsNumber.t9(size(Tendons.('t9'),2))=counter;
%         PointsNumber.t15u(1)=counter;
%         counter=counter+1;
%         % Point Hr
% %         Hr=band(1:3,1);
%         band=Tendons.t3r';
%         TendonsConv=[TendonsConv;band(1,1:3)];
%         Map(counter,1).bands.t3r=1;
%         Map(counter,1).bands.t2r=size(Tendons.('t2r'),2);
%         Map(counter,1).bands.t9=1;
%         Map(counter,1).bands.t15r=1;
%         PointsNumber.t3r(1)=counter;
%         PointsNumber.t2r(size(Tendons.('t2r'),2))=counter;
%         PointsNumber.t9(1)=counter;
%         PointsNumber.t15r(1)=counter;
%         counter=counter+1;
%        % Point Bu
% %         Bu=band(1:3,1);
%         band=Tendons.t4u';
%         TendonsConv=[TendonsConv;band(1,1:3)];
%         Map(counter,1).bands.t4u=1;
%         Map(counter,1).bands.t3u=size(Tendons.('t3u'),2);
%         Map(counter,1).bands.t5u=1;
%         PointsNumber.t4u(1)=counter;
%         PointsNumber.t3u(size(Tendons.('t3u'),2))=counter;
%         PointsNumber.t5u(1)=counter;
%         counter=counter+1;
%        % Point Br
% %         Br=band(1:3,1);
%         band=Tendons.t4r';
%         TendonsConv=[TendonsConv;band(1,1:3)];
%         Map(counter,1).bands.t4r=1;
%         Map(counter,1).bands.t3r=size(Tendons.('t3r'),2);
%         Map(counter,1).bands.t5r=1;
%         PointsNumber.t4r(1)=counter;
%         PointsNumber.t3r(size(Tendons.('t3r'),2))=counter;
%         PointsNumber.t5r(1)=counter;
%         counter=counter+1;
%         % Point C
% %         C=band(1:3,1);
%         band=Tendons.t7u';
%         TendonsConv=[TendonsConv;band(1,1:3)];
%         Map(counter,1).bands.t7u=1;
%         Map(counter,1).bands.t7r=1;
%         Map(counter,1).bands.t6=size(Tendons.('t6'),2);
%         Map(counter,1).bands.t8=1;
%         PointsNumber.t7u(1)=counter;
%         PointsNumber.t7r(1)=counter;
%         PointsNumber.t6(size(Tendons.('t6'),2))=counter;
%         PointsNumber.t8(1)=counter;
%         counter=counter+1;
%         band=Tendons.t10u';
%        % Points F and Eu        
%        TendonsConv=[TendonsConv;band(1,1:3);band(size(band,1),1:3)];
% %         F=band(1:3,1);
%         Map(counter,1).bands.t10u=1;
%         Map(counter,1).bands.t10r=1;
%         Map(counter,1).bands.t5r=size(Tendons.('t5r'),2);
%         Map(counter,1).bands.t12=1;
%         Map(counter,1).bands.t5u=size(Tendons.('t5u'),2);
%         Map(counter,1).bands.t8=size(Tendons.('t8'),2);
%         PointsNumber.t10u(1)=counter;
%         PointsNumber.t10r(1)=counter;
%         PointsNumber.t5r(size(Tendons.('t5r'),2))=counter;
%         PointsNumber.t12(1)=counter;
%         PointsNumber.t5u(size(Tendons.('t5u'),2))=counter;
%         PointsNumber.t8(size(Tendons.('t8'),2))=counter;
% %         Eu=band(1:3,size(band,1));
%           counter=counter+1;
%         Map(counter,1).bands.t10u=size(band,1);
%         Map(counter,1).bands.t13u=1;
%         Map(counter,1).bands.t4u=size(Tendons.('t4u'),2);
%         Map(counter,1).bands.t7u=size(Tendons.('t7u'),2);
%         PointsNumber.t10u(size(band,1))=counter;
%         PointsNumber.t13u(1)=counter;
%         PointsNumber.t4u(size(Tendons.('t4u'),2))=counter;
%         PointsNumber.t7u(size(Tendons.('t7u'),2))=counter;
%         counter=counter+1;
%         band=Tendons.t10r';
%        % Point Er
% %         Er=band(1:3,size(band,1)); 
%         TendonsConv=[TendonsConv;band(size(band,1),1:3)];
%         Map(counter,1).bands.t10r=size(band,1);
%         Map(counter,1).bands.t17=1;
%         Map(counter,1).bands.t13r=1;
%         Map(counter,1).bands.t4r=size(Tendons.('t4r'),2);
%         Map(counter,1).bands.t7r=size(Tendons.('t7r'),2);
%         PointsNumber.t10r(size(band,1))=counter;
%         PointsNumber.t13r(1)=counter;
%         PointsNumber.t17(1)=counter;
%         PointsNumber.t4r(size(Tendons.('t4r'),2))=counter;
%         PointsNumber.t7r(size(Tendons.('t7r'),2))=counter;
%         counter=counter+1;
%         band=Tendons.t11u';
%        % Points J and Ku
% %         J=band(1:3,1);
%         TendonsConv=[TendonsConv;band(1,1:3);band(size(band,1),1:3)];
%         Map(counter,1).bands.t11u=1;
%         Map(counter,1).bands.t11r=1;
%         Map(counter,1).bands.t14=1;
%         Map(counter,1).bands.t12=size(Tendons.('t12'),2);
%         PointsNumber.t11u(1)=counter;
%         PointsNumber.t11r(1)=counter;
%         PointsNumber.t14(1)=counter;
%         PointsNumber.t12(size(Tendons.('t12'),2))=counter;
% %         Ku=band(1:3,size(band,1));
%         counter=counter+1;
%         Map(counter,1).bands.t11u=size(band,1);
%         Map(counter,1).bands.t16u=1;
%         Map(counter,1).bands.t13u=size(Tendons.('t13u'),2);
%         PointsNumber.t11u(size(band,1))=counter;
%         PointsNumber.t16u(1)=counter;
%         PointsNumber.t13u(size(Tendons.('t13u'),2))=counter;
%         counter=counter+1;
% 
%         band=Tendons.t11r';
%        % Point Kr
% %         Kr=band(1:3,size(band,1));
%         TendonsConv=[TendonsConv;band(size(band,1),1:3)];
%         Map(counter,1).bands.t11r=size(band,1);
%         Map(counter,1).bands.t16r=1;
%         Map(counter,1).bands.t13r=size(Tendons.('t13r'),2);
%         PointsNumber.t11r(size(band,1))=counter;
%         PointsNumber.t16r(1)=counter;
%         PointsNumber.t13r(size(Tendons.('t13r'),2))=counter;
%         counter=counter+1;
%         band=Tendons.t14';
%         % Point N
% %         N=band(1:3,size(band,1));
%         TendonsConv=[TendonsConv;band(size(band,1),1:3)];
%         Map(counter,1).bands.t14=size(band,1);
%         PointsNumber.t14(size(band,1))=counter;
%         counter=counter+1;
%         band=Tendons.t16u';
%         % Point Qu
% %         Qu=band(1:3,size(band,1));
%         TendonsConv=[TendonsConv;band(size(band,1),1:3)];
%         Map(counter,1).bands.t16u=size(band,1);
%         PointsNumber.t16u(size(band,1))=counter;
%         counter=counter+1;
%         
%         band=Tendons.t16r';
%         % Point Qr
% %         Qr=band(1:3,size(band,1));
%         TendonsConv=[TendonsConv;band(size(band,1),1:3)];
%         Map(counter,1).bands.t16r=size(band,1);
%         PointsNumber.t16r(size(band,1))=counter;
%         counter=counter+1;
%         band=Tendons.t17';
%         % Point R
% %         R=band(1:3,size(band,1));
%        TendonsConv=[TendonsConv;band(size(band,1),1:3)];
%        Map(counter,1).bands.t17=size(band,1);
%        PointsNumber.t17(size(band,1))=counter;
%        counter=counter+1;
% 
% for i=1:size(names,1);
%     band=Tendons.(char(names(i)))';
%     TendonsConv=[TendonsConv;band(2:size(band,1)-1,:)];
%     
%     for j=2:size(band,1)-1
%         Map(counter,1).bands.(char(names(i)))=j;
%         PointsNumber.(char(names(i)))(j)=counter;
%         if j==2
%             Neighbours(counter,1:2)=[PointsNumber.(char(names(i)))(1)  counter+1];
%         else if j==size(band,1)-1
%                 Neighbours(counter,1:2)=[counter-1 PointsNumber.(char(names(i)))(size(band,1))];
%             else
%                 Neighbours(counter,1:2)=[counter-1 counter+1];
%             end
%         end
%         counter=counter+1;
%     end
% end
% 
% Neighbours(1,1)=PointsNumber.t1(2);
% Neighbours(2,1)=PointsNumber.t6(2);
% Neighbours(3,1)=PointsNumber.t15u(size(PointsNumber.t15u,2)-1);
% Neighbours(4,1)=PointsNumber.t15r(size(PointsNumber.t15r,2)-1);
% Neighbours(5,1:3)=[PointsNumber.t2r(2) PointsNumber.t1(size(PointsNumber.t1,2)-1) PointsNumber.t2u(2)];
% Neighbours(6,1:4)=[PointsNumber.t2u(size(PointsNumber.t2u,2)-1) PointsNumber.t9(size(PointsNumber.t9,2)-1) PointsNumber.t15u(2) PointsNumber.t3u(2)];
% Neighbours(7,1:4)=[PointsNumber.t2r(size(PointsNumber.t2u,2)-1) PointsNumber.t9(2) PointsNumber.t15r(2) PointsNumber.t3r(2)];
% Neighbours(8,1:3)=[PointsNumber.t3u(size(PointsNumber.t3u,2)-1) PointsNumber.t5u(2) PointsNumber.t4u(2)];
% Neighbours(9,1:3)=[PointsNumber.t3r(size(PointsNumber.t3r,2)-1) PointsNumber.t5r(2) PointsNumber.t4r(2)];
% Neighbours(10,1:4)=[PointsNumber.t7r(2) PointsNumber.t6(size(PointsNumber.t6,2)-1) PointsNumber.t8(2) PointsNumber.t7u(2)];
% Neighbours(11,1:6)=[PointsNumber.t10r(2) PointsNumber.t5r(size(PointsNumber.t5r,2)-1) PointsNumber.t12(2) PointsNumber.t5u(size(PointsNumber.t5u,2)-1) PointsNumber.t8(size(PointsNumber.t8,2)-1) PointsNumber.t10u(2)];
% Neighbours(12,1:4)=[PointsNumber.t13u(2) PointsNumber.t4u(size(PointsNumber.t4u,2)-1) PointsNumber.t7u(size(PointsNumber.t7u,2)-1) PointsNumber.t10u(size(PointsNumber.t10u,2)-1)];
% Neighbours(13,1:5)=[PointsNumber.t17(2) PointsNumber.t13r(2) PointsNumber.t4r(size(PointsNumber.t4r,2)-1) PointsNumber.t7r(size(PointsNumber.t7r,2)-1) PointsNumber.t10r(size(PointsNumber.t10r,2)-1)];
% Neighbours(14,1:4)=[PointsNumber.t11r(2) PointsNumber.t14(2) PointsNumber.t12(size(PointsNumber.t12,2)-1) PointsNumber.t11u(2)  ];
% Neighbours(15,1:3)=[PointsNumber.t16u(2) PointsNumber.t13u(size(PointsNumber.t13u,2)-1) PointsNumber.t11u(size(PointsNumber.t11u,2)-1)];
% Neighbours(16,1:3)=[PointsNumber.t16r(2) PointsNumber.t13r(size(PointsNumber.t13u,2)-1) PointsNumber.t11r(size(PointsNumber.t11u,2)-1)];
% Neighbours(17,1)=PointsNumber.t14(size(PointsNumber.t14,2)-1);
% Neighbours(18,1)=PointsNumber.t16u(size(PointsNumber.t16u,2)-1);
% Neighbours(19,1)=PointsNumber.t16r(size(PointsNumber.t16r,2)-1);
% Neighbours(20,1)=PointsNumber.t17(size(PointsNumber.t17,2)-1);
end

