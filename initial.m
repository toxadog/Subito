function [Tendons Nodes gLines Length]=initial(Param)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here 
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
Length.n1=L(6);
Length.n2=L(6);
Length.n3=L(13);
Length.t1=L(1);
Length.t2=L(10);
Length.t3=L(23);
Length.t4=L(24);
Length.t5=L(25);
Length.t6=L(22);
Length.t7=L(26);
Length.t8=L(27);

%% Create pricipal tendons
Tendons.n1=CreateBandConstr(Nodes(:,6),Nodes(:,10),PulleyPIPu,Param,round(L(6)*pointsdens)+1);
Tendons.n2=CreateBandConstr(Nodes(:,7),Nodes(:,11),PulleyPIPr,Param,round(L(6)*pointsdens)+1);
Tendons.n3=CreateBandConstr(Nodes(:,8),Nodes(:,9),bonepoints(:,3),Param,round(L(13)*pointsdens)+1);
Tendons.t1=CreateBand(Nodes(:,1),Nodes(:,5),round(L(1)*pointsdens)+1);
Tendons.t2=CreateBand(Nodes(:,2),Nodes(:,8),round(L(10)*pointsdens)+1);
Tendons.t3=CreateBand(Nodes(:,6),Nodes(:,3),round(L(23)*pointsdens)+1);
Tendons.t4=CreateBand(Nodes(:,7),Nodes(:,4),round(L(24)*pointsdens)+1);
Tendons.t5=CreateBandConstr(Nodes(:,13),Nodes(:,15),PulleyIntu,Param,round(L(25)*pointsdens)+1);
Tendons.t6=CreateBandConstr(Nodes(:,12),Nodes(:,16),bonepoints(:,2),Param,round(L(22)*pointsdens)+1);
Tendons.t7=CreateBandConstr(Nodes(:,14),Nodes(:,17),PulleyIntr,Param,round(L(26)*pointsdens)+1);
Tendons.t8=CreateBandConstr(Nodes(:,11),Nodes(:,18),PulleyLu,Param,round(L(27)*pointsdens)+1);
%% Define grid interpoint distance
Length.g1=[L(28) L(29)];
Length.g2=[L(30) L(31)];
Length.g3=[L(32) L(33)];
Length.g4=[L(34) L(35)];
%% Create intercrossing fibers 
gLines=[];
NPg1=round(max(Length.g1(:))*pointsdens)+1;
NPg2=round(max(Length.g2(:))*pointsdens)+1;
NPg3=round(max(Length.g3(:))*pointsdens)+1;
NPg4=round(max(Length.g4(:))*pointsdens)+1;
zone1=[0 0.7; 0.0 0.7]; %transform to[0.3 0.8]
zone2=[0.3 1.0; 0.32 1.0];%transform to[0.3 0.8]
[Tendons.g1, gLines.g1] = CreateGrid(Tendons.n1,Tendons.n3,zone1,PulleyPIPu,Param,NPg1);
[Tendons.g2, gLines.g2] = CreateGrid(Tendons.n1,Tendons.n3,zone2,NaN,Param,NPg2);
[Tendons.g3, gLines.g3] = CreateGrid(Tendons.n2,Tendons.n3,zone2,NaN,Param,NPg3);
[Tendons.g4, gLines.g4] = CreateGrid(Tendons.n2,Tendons.n3,zone1,PulleyPIPr,Param,NPg4);
%% Define membrane interpoint distance
Length.s1=[L(14)  L(3) L(2)];
Length.m1=[L(15) L(17)  L(19) L(20)];
Length.m2=[L(15) L(17)  L(19) L(21)];
%% Create membtanes
NPsh=round(Length.s1(1)*pointsdens)+1;
NPsv=round(max(Length.s1(2),Length.s1(3))*pointsdens)+1;
NPm1h=round(max(Length.m1(1),Length.m1(2))*pointsdens)+1;
NPm1v=round(max(Length.m1(3),Length.m1(4))*pointsdens)+1;
NPm2h=round(max(Length.m2(1),Length.m2(2))*pointsdens)+1;
NPm2v=round(max(Length.m2(3),Length.m2(4))*pointsdens)+1;
Tendons.s1=makeTriang(Nodes(:,7),Nodes(:,6),Nodes(:,5),NPsh,NPsv);
Tendons.m1=makeQuad(Nodes(:,12),Nodes(:,13),Nodes(:,10),Nodes(:,9),NPm1h,NPm1v);
Tendons.m2=makeQuad(Nodes(:,12),Nodes(:,14),Nodes(:,11),Nodes(:,9),NPm2h,NPm2v);
%% Pushout Tendons
Tendons=PushoutTendon(Tendons,Param);
end
