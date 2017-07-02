function [Tendons Nodes]=initial(Param)
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
%Transfor from local to global
Node(:,1)=local2cart(O1,DIP,PIP,MCP,Param);
Node(:,2)=local2cart(O2,DIP,PIP,MCP,Param);
Node(:,3)=local2cart(O3u,DIP,PIP,MCP,Param);
Node(:,4)=local2cart(O3r,DIP,PIP,MCP,Param);
Node(:,5)=local2cart(A,DIP,PIP,MCP,Param);
Node(:,6)=local2cart(Hu,DIP,PIP,MCP,Param);
Node(:,7)=local2cart(Hr,DIP,PIP,MCP,Param);
Node(:,8)=local2cart(C,DIP,PIP,MCP,Param);
Node(:,9)=local2cart(F,DIP,PIP,MCP,Param);
Node(:,10)=local2cart(Eu,DIP,PIP,MCP,Param);
Node(:,11)=local2cart(Er,DIP,PIP,MCP,Param);
Node(:,12)=local2cart(J,DIP,PIP,MCP,Param);
Node(:,13)=local2cart(Ku,DIP,PIP,MCP,Param);
Node(:,14)=local2cart(Kr,DIP,PIP,MCP,Param);

%Muscle attachements
Node(:,15)=Node(:,13)+L(25)*(M(:,1)-Node(:,13))/modulus(M(:,1)-Node(:,13));
Node(:,16)=Node(:,12)+L(22)*(M(:,2)-Node(:,12))/modulus(M(:,2)-Node(:,12));
Node(:,17)=Node(:,14)+L(26)*(M(:,3)-Node(:,14))/modulus(M(:,3)-Node(:,14));
Node(:,18)=Node(:,11)+L(27)*(M(:,4)-Node(:,11))/modulus(M(:,4)-Node(:,11));

%% Create pricipal tendons
Tendons.t1=CreateBand(Node(:,1),Node(:,5),round(L(1)*pointsdens));
Tendons.t2=CreateBandConstr(Node(:,6),Node(:,10),PulleyPIPu,Param,round(L(6)*pointsdens));
Tendons.t3=CreateBandConstr(Node(:,7),Node(:,11),PulleyPIPr,Param,round(L(6)*pointsdens));
Tendons.t4=CreateBand(Node(:,2),Node(:,8),round(L(10)*pointsdens));
Tendons.t5=CreateBand(Node(:,8),Node(:,9),round(L(13)*pointsdens));
Tendons.t6=CreateBand(Node(:,6),Node(:,3),round(L(23)*pointsdens));
Tendons.t7=CreateBand(Node(:,7),Node(:,4),round(L(24)*pointsdens));
Tendons.t8=CreateBandConstr(Node(:,13),Node(:,15),PulleyIntu,Param,round(L(25)*pointsdens));
Tendons.t9=CreateBandConstr(Node(:,12),Node(:,16),bonepoints(:,2),Param,round(L(22)*pointsdens));
Tendons.t10=CreateBandConstr(Node(:,14),Node(:,17),PulleyIntr,Param,round(L(26)*pointsdens));
Tendons.t11=CreateBandConstr(Node(:,11),Node(:,18),PulleyLu,Param,round(L(27)*pointsdens));
%% Create intercrossing fibers
RR=[0.3 0.3; 0.8 0.8];
Lg=[size(Tendons.t2,2) size(Tendons.t2,2);size(Tendons.t5,2)  size(Tendons.t5,2)];
LL=round(Lg.*RR);
Points11=1:round(LL(1,1));
Points22=Lg(2,2)+1-round(LL(2,2)):Lg(2,2);
Nlines1=max(length(Points11),length(Points22));
Points12=Lg(1,2)+1-round(LL(1,2)):Lg(1,2);
Points21=1:round(LL(2,1));
Nlines2=max(length(Points12),length(Points21));
if max(Points11)>min(Points12)
    Points1=min(Points11):max(Points12);
else Points1=[Points11 Points12];
end
if max(Points21)>min(Points22)
    Points2=min(Points21):max(Points22);
else Points2=[Points21 Points22];
end
% Nodes=[Nodes;ILBU(:,Points1)';EMB(:,Points2)';ILBR(:,Points1)'];
[Lline1 Rline1] = getGrid(Points11,Points22);
Line1=[Lline1;Rline1];
[Lline2 Rline2] = getGrid(Points12,Points21);
Line2=[Lline2;Rline2];
for i=1:size(Line1,2)
    Tendons.(horzcat('gr1_',int2str(i)))=CreateBandConstr(Tendons.t2(:,Line1(1,i)),Tendons.t5(:,Line1(2,i)),PulleyPIPu,Param,40);
end
for i=1:size(Line2,2)
    Tendons.(horzcat('gr2_',int2str(i)))=CreateBand(Tendons.t2(:,Line2(1,i)),Tendons.t5(:,Line2(2,i)),40);
end
for i=1:size(Line2,2)
    Tendons.(horzcat('gr3_',int2str(i)))=CreateBand(Tendons.t3(:,Line2(1,i)),Tendons.t5(:,Line2(2,i)),40);
end
for i=1:size(Line1,2)
    Tendons.(horzcat('gr4_',int2str(i)))=CreateBandConstr(Tendons.t3(:,Line1(1,i)),Tendons.t5(:,Line1(2,i)),PulleyPIPr,Param,40);
end

%% Create membtanes
Tendons.m1=makeTriang(Node(:,7),Node(:,6),Node(:,5),Param);
Tendons.m2=makeQuad(Node(:,12),Node(:,13),Node(:,10),Node(:,9),Param);
Tendons.m3=makeQuad(Node(:,12),Node(:,14),Node(:,11),Node(:,9),Param);
%%
Nodes=0;
%% Pushout Tendons
Tendons=PushoutTendon(Tendons,Param);
%%
% NElements=size(Nodes,2)+

end

