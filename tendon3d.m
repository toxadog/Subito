% clc;
% mex pushoutc_mat.c pushoutc.c minusc.c dotprodc.c sum_a.c modulusc.c point2linec.c
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
Param.Pulleys=[PulleyM3(2:3,:), PulleyM4(2:3,:)];
%JAngles=(DIP,PIP,MCP)
JAngles=[10*pi/180,10*pi/180,10*pi/180];
Param.currentbonepoints=BonesConf(JAngles(1),JAngles(2),JAngles(3),Param);
figure;
CreateWindow(Param.currentbonepoints);
[Tendons Nodes gLines Length]=initial(Param);
[Points, Neighbours, Map, NElements,Penalty]=convTendons(Tendons, Nodes, gLines);
L = createLength(NElements,gLines,Tendons,Length);
K = createStiffness(NElements,gLines,Tendons);
[Points,Neighbours,L,K,NElements,pos1,pos2]=mergeQuad(Points,Neighbours,L,K,NElements,35,36);
drawband(Tendons);
MuscleForces = [0.3*9.8; 0.3*9.8; 0.3*9.8; 0.3*9.8];
Forces=zeros(size(Points));
Forces(15,:)=MuscleForces(1)*(M1-Points(15,:)')/modulus(M1-Points(15,:)');
Forces(16,:)=MuscleForces(2)*(M2-Points(16,:)')/modulus(M2-Points(16,:)');
Forces(17,:)=MuscleForces(3)*(M3-Points(17,:)')/modulus(M3-Points(17,:)');
Forces(18,:)=MuscleForces(4)*(M4-Points(18,:)')/modulus(M4-Points(18,:)');
ForcePoints=zeros(size(Points));
ForcePoints(15:18,:)=Param.M(:,1:4)';
%%
[Points, D, D2] = PointMove(Points,Neighbours,Forces,Param,L);
%%
IntForces = AddForces(Points,Neighbours,L,K);
ColorStr2=makemap(IntForces,Map);
Tendons2 = iconvTendons(Points ,Map);
ForcesStr2=iconvForces(IntForces,Map);
[Tendons2,ColorStr2,ForcesStr2] = imergeQuad(Tendons2,ColorStr2,ForcesStr2);
figure;
CreateWindow(Param.currentbonepoints);
drawbandColor(Tendons2,ColorStr2)
drawforces(Points,Forces);
%%
nit=1000000;
alpha=7;
Points2=gradc(Points,int32(Neighbours), L,Forces,K,int32(nit),alpha,kpen,Param.hand,Param.currentbonepoints,ForcePoints,Param.Pulleys,Penalty);
%%
IntForces = AddForces(Points2,Neighbours,L,K);
ColorStr2=makemap(IntForces,Map);
Tendons2 = iconvTendons(Points2 ,Map);
ForcesStr2=iconvForces(IntForces,Map);
[Tendons2,ColorStr2,ForcesStr2] = imergeQuad(Tendons2,ColorStr2,ForcesStr2);
figure;
CreateWindow(Param.currentbonepoints);
drawbandColor(Tendons2,ColorStr2)
drawforces(Points2,Forces);
%%
n1=[int2str(MuscleForces(1)'/max(MuscleForces)),int2str(MuscleForces(2)'/max(MuscleForces)),int2str(MuscleForces(3)'/max(MuscleForces)),int2str(MuscleForces(4)'/max(MuscleForces))];
n2=[int2str(abs(JAngles(1)*180/pi)),int2str(abs(JAngles(2)*180/pi)),int2str(abs(JAngles(3)*180/pi))];
name=horzcat('Posture',n2,'Forces',n1);
save(name,'Neighbours','L','k1','Points2','ForcesStr2','Tendons2','ColorStr2','Forces');
