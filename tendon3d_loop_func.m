function tendon3d_loop_func(ForceLevel,JAngles)
% clc;
% mex pushoutc_mat.c pushoutc.c minusc.c dotprodc.c sum_a.c modulusc.c point2linec.c
MuscleForcesDB = [0 0 0 0; 1 0 0 0;0 1 0 0; 0 0 0 1;...
    1 1 0 0;1 0 1 0;1 0 0 1;0 1 0 1;0 0 1 1;...
    1 1 1 0; 1 1 0 1; 1 0 1 1; 0 1 1 1; 1 1 1 1]';
Npost=size(MuscleForcesDB,2);
ForcesRes=zeros(2,Npost);
TorquesRes=zeros(4,Npost);
for maincnt=1:Npost
Param=createParam;
Param.pointsdens=1;
Param.precision =1e1;
Param.MaxIter=1600;
Param.Step=1e-6;
Param.PulleyR=2;
[Param.hand Param.L Param.Elast Param.TendS] = readfile;
Param.anginit=[0.855 1.48];
Param.mu=[0.2 0.2 0.9];
Param.Step_opt=1e-3;
Param.MaxIter_opt=5;
Param.precision_opt=1e-4;
k1=173000/2;%individual for each spring;
kpen=173000;
global hand;
hand=Param.hand;
% hand=[l1    l2    l3    l4    r1    r2    r3    r4    R1    R2   R3];
[M1,M2,M3,M4,PulleyM1,PulleyM3,PulleyM4] = MusclePoints(Param);
Param.M=[M1 M2 M3 M4 PulleyM1 PulleyM3 PulleyM4];
%JAngles=(DIP,PIP,MCP)

Param.currentbonepoints=BonesConf(JAngles(1)*pi/180,JAngles(2)*pi/180,JAngles(3)*pi/180,Param);
% figure;
% CreateWindow(Param.currentbonepoints);
[Tendons Nodes gLines Length]=initial(Param);
[Points, Neighbours, Map, NElements,Penalty]=convTendons(Tendons, Nodes, gLines);
L = createLength(NElements,gLines,Tendons,Length);
K = createStiffness(NElements,gLines,Tendons);
[Points,Neighbours,L,K,NElements,pos1,pos2]=mergeQuad(Points,Neighbours,L,K,NElements,35,36);
% drawband(Tendons);
MuscleForces = MuscleForcesDB(:,maincnt)*0.3*9.8*ForceLevel;
Forces=zeros(size(Points));
Forces(15,:)=MuscleForces(1)*(M1-Points(15,:)')/modulus(M1-Points(15,:)');
Forces(16,:)=MuscleForces(2)*(M2-Points(16,:)')/modulus(M2-Points(16,:)');
Forces(17,:)=MuscleForces(3)*(M3-Points(17,:)')/modulus(M3-Points(17,:)');
Forces(18,:)=MuscleForces(4)*(M4-Points(18,:)')/modulus(M4-Points(18,:)');
ForcePoints=zeros(size(Points));
ForcePoints(15:18,:)=Param.M(:,1:4)';

%%
nit=1e2;
alpha=7;
Points2=gradc(Points,int32(Neighbours), L,Forces,K,int32(nit),alpha,kpen,Param.hand,Param.currentbonepoints,ForcePoints,Param.Pulleys,Penalty);
%%
IntForces = AddForces(Points2,Neighbours,L,K);
ColorStr2=makemap(IntForces,Map);
Tendons2 = iconvTendons(Points2 ,Map);
ForcesStr2=iconvForces(IntForces,Map);
[Tendons2,ColorStr2,ForcesStr2] = imergeQuad(Tendons2,ColorStr2,ForcesStr2);
% figure;
% CreateWindow(Param.currentbonepoints);
% drawbandColor(Tendons2,ColorStr2)
% drawforces(Points2,Forces);
%%
Nodes=[4 3 3 3];
TendForces = getTendonForces(Points2,Param,Penalty,kpen,K,L,Neighbours,Nodes);
J1=Param.currentbonepoints(:,2)';
J2=Param.currentbonepoints(:,3)';
J3=Param.currentbonepoints(:,4)';
X = [1 0 0];
Y = [0 1 0];
Joints=struct('JointPoint',{J1 J1 J2 J3},'JointAxe', {Y X X X}, 'NBone', {1 1 2 3} );
TorquesRes(:,maincnt) = getJointTorques(Joints, Points2, TendForces);
%%
n1=[int2str(MuscleForcesDB(1,maincnt)), int2str(MuscleForcesDB(2,maincnt)),int2str(MuscleForcesDB(3,maincnt)),int2str(MuscleForcesDB(4,maincnt))];
n2=[int2str(abs(JAngles(1))),int2str(abs(JAngles(2))),int2str(abs(JAngles(3)))];
name1=horzcat('Posture',n2,'Forces',n1,'ForceLevel',int2str(round(100*ForceLevel)));
save(name1,'Neighbours','L','k1','Points2','ForcesStr2','Tendons2','ColorStr2','Forces','Param');
ForcesRes(:,maincnt)=[ForcesStr2.t1(1) ForcesStr2.t2(1)];
end
name2=horzcat('Posture',n2,'ForceLevel',int2str(round(100*ForceLevel)));
save(name2,'ForcesRes','TorquesRes');
end