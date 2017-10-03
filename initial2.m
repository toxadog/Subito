function [Tendons Nodes gLines Length]=initial2(Param)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here 
gLines=[];
bonepoints = Param.currentbonepoints;
hand = Param.hand;
L = Param.L;
pointsdens = Param.pointsdens;
mu = Param.mu;
M = Param.M;
l1=hand(1);
l2=hand(2);
l3=hand(3);
R2=hand(10);
P1=bonepoints(:,1);
P2=bonepoints(:,2);
P3=bonepoints(:,3);
P4=bonepoints(:,4);
P5=bonepoints(:,5);
MCP=getangleSigned(P3-P2,P2-P1);
PIP=getangleSigned(P4-P3,P3-P2);
DIP=getangleSigned(P5-P4,P4-P3);
%% Create constraints
PulleyPIPu=bonepoints(:,3)+[R2;0;0];
PulleyPIPr=bonepoints(:,3)+[-R2;0;0];
PulleyIntu=M(:,5);
PulleyIntr=M(:,6);
PulleyLu=M(:,7);
%% Create Nodes
O1=[0,mu(1)*l1,7];
O2=[0,mu(2)*l2,5];
O3u=[0.9*pi,l3*mu(3),3];
O3r=[-0.9*pi,l3*mu(3),3];
A=createPointLong(O1,L(1), Param);
Hc=createPointLong(A,sqrt(L(2)^2-(L(14)/2)^2), Param);
Hu=createPointTrans(Hc,L(14)/2,Param);
Hr=createPointTrans(Hc,-L(14)/2,Param);
C=createPointLong(O2,L(10), Param);
F=createPointLong(C,L(13), Param);
Eu=createPointTrans(F,L(15),Param);
Er=createPointTrans(F,-L(15),Param);
J=createPointLong(F,L(19), Param);
Ku=createPointTrans(J,L(17),Param);
Kr=createPointTrans(J,-L(17),Param);
% N=createPointLong(J,L(22),Param);
%Transformation from local to global
Nodes(:,1)=local2cart(O1,DIP,PIP,MCP,Param);
Nodes(:,2)=local2cart(O2,DIP,PIP,MCP,Param);
Nodes(:,3)=local2cart(O3u,DIP,PIP,MCP,Param);
Nodes(:,4)=local2cart(O3r,DIP,PIP,MCP,Param);
Nodes(:,5)=local2cart(A,DIP,PIP,MCP,Param);
Nodes(:,6)=local2cart(Hu,DIP,PIP,MCP,Param);
Nodes(:,7)=local2cart(Hr,DIP,PIP,MCP,Param);
Nodes(:,8)=local2cart(C,DIP,PIP,MCP,Param);
Nodes(:,9)=local2cart(F,DIP,PIP,MCP,Param);
Nodes(:,10)=local2cart(Eu,DIP,PIP,MCP,Param);
Nodes(:,11)=local2cart(Er,DIP,PIP,MCP,Param);
Nodes(:,12)=local2cart(J,DIP,PIP,MCP,Param);
Nodes(:,13)=local2cart(Ku,DIP,PIP,MCP,Param);
Nodes(:,14)=local2cart(Kr,DIP,PIP,MCP,Param);

%Muscle attachements
Nodes(:,15)=Nodes(:,13)+L(25)*(M(:,1)-Nodes(:,13))/modulus(M(:,1)-Nodes(:,13));
% Nodes(:,16)=Nodes(:,12)+L(22)*(M(:,2)-Nodes(:,12))/modulus(M(:,2)-Nodes(:,12));
Nodes(:,16)=local2cart(createPointLong(J,L(22),Param),DIP,PIP,MCP,Param);
Nodes(:,17)=Nodes(:,14)+L(26)*(M(:,3)-Nodes(:,14))/modulus(M(:,3)-Nodes(:,14));
Nodes(:,18)=Nodes(:,11)+L(27)*(M(:,4)-Nodes(:,11))/modulus(M(:,4)-Nodes(:,11));

%% Define tendon interpoint distance
%the L array will be restructured 
Length.t1=L(6);
Length.t2=L(6);
Length.t3=L(13);
Length.t4=L(1);
Length.t5=L(10);
Length.t6=L(23);
Length.t7=L(24);
Length.t8=L(25);
Length.t9=L(22);
Length.t10=L(26);
Length.t11=L(27);
Length.t12=L(8);
Length.t13=L(11);
Length.t14=L(12);
Length.t15=L(9);
Length.t16=L(2);
Length.t17=L(3);
Length.t18=L(14);
Length.t19=L(17);
Length.t20=L(15);
Length.t21=L(20);
Length.t22=L(18);
Length.t23=L(16);
Length.t24=L(21);
Length.t25=L(19);
%% Create pricipal tendons
Tendons.t1=CreateBandConstr(Nodes(:,6),Nodes(:,10),PulleyPIPu,Param,round(L(6)*pointsdens)+1);
Tendons.t2=CreateBandConstr(Nodes(:,7),Nodes(:,11),PulleyPIPr,Param,round(L(6)*pointsdens)+1);
Tendons.t3=CreateBandConstr(Nodes(:,8),Nodes(:,9),bonepoints(:,3),Param,round(L(13)*pointsdens)+1);
Tendons.t4=CreateBand(Nodes(:,1),Nodes(:,5),round(L(1)*pointsdens)+1);
Tendons.t5=CreateBand(Nodes(:,2),Nodes(:,8),round(L(10)*pointsdens)+1);
Tendons.t6=CreateBand(Nodes(:,6),Nodes(:,3),round(L(23)*pointsdens)+1);
Tendons.t7=CreateBand(Nodes(:,7),Nodes(:,4),round(L(24)*pointsdens)+1);
Tendons.t8=CreateBandConstr(Nodes(:,13),Nodes(:,15),PulleyIntu,Param,round(L(25)*pointsdens)+1);
Tendons.t9=CreateBandConstr(Nodes(:,12),Nodes(:,16),bonepoints(:,2),Param,round(L(22)*pointsdens)+1);
Tendons.t10=CreateBandConstr(Nodes(:,14),Nodes(:,17),PulleyIntr,Param,round(L(26)*pointsdens)+1);
Tendons.t11=CreateBandConstr(Nodes(:,11),Nodes(:,18),PulleyLu,Param,round(L(27)*pointsdens)+1);
%diagonal
Tendons.t12=CreateBandConstr(Nodes(:,6),Nodes(:,9),PulleyPIPu,Param,round(L(8)*pointsdens)+1);
Tendons.t13=CreateBand(Nodes(:,8),Nodes(:,10),round(L(11)*pointsdens)+1);
Tendons.t14=CreateBand(Nodes(:,8),Nodes(:,11),round(L(12)*pointsdens)+1);
Tendons.t15=CreateBandConstr(Nodes(:,7),Nodes(:,9),PulleyPIPr,Param,round(L(9)*pointsdens)+1);
%triangular
Tendons.t16=CreateBand(Nodes(:,5),Nodes(:,6),round(L(2)*pointsdens)+1);
Tendons.t17=CreateBand(Nodes(:,5),Nodes(:,7),round(L(3)*pointsdens)+1);
Tendons.t18=CreateBand(Nodes(:,7),Nodes(:,6),round(L(14)*pointsdens)+1);
%extensor hood
Tendons.t19=CreateBand(Nodes(:,12),Nodes(:,13),round(L(17)*pointsdens)+1);
Tendons.t20=CreateBand(Nodes(:,9),Nodes(:,10),round(L(15)*pointsdens)+1);
Tendons.t21=CreateBand(Nodes(:,10),Nodes(:,13),round(L(20)*pointsdens)+1);
Tendons.t22=CreateBand(Nodes(:,12),Nodes(:,14),round(L(18)*pointsdens)+1);
Tendons.t23=CreateBand(Nodes(:,9),Nodes(:,11),round(L(16)*pointsdens)+1);
Tendons.t24=CreateBand(Nodes(:,11),Nodes(:,14),round(L(21)*pointsdens)+1);
Tendons.t25=CreateBand(Nodes(:,9),Nodes(:,12),round(L(19)*pointsdens)+1);
%% Pushout Tendons
Tendons=PushoutTendon(Tendons,Param);
end
