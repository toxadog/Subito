% clc;
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
global hand;
hand=Param.hand;
% hand=[l1    l2    l3    l4    r1    r2    r3    r4    R1    R2   R3];
[M1,M2,M3,M4,PulleyM1,PulleyM3,PulleyM4] = MusclePoints(Param);
Param.M=[M1 M2 M3 M4 PulleyM1 PulleyM3 PulleyM4];
%JAngles=(DIP,PIP,MCP)
JAngles=[0*pi/180,0*pi/180,0*pi/180];
Param.currentbonepoints=BonesConf(JAngles(1),JAngles(2),JAngles(3),Param);
CreateWindow(Param.currentbonepoints);
[Tendons Nodes gLines Length]=initial(Param);
[Points, Neighbours, Map, NElements]=convTendons(Tendons, Nodes, gLines);
L = createLength(NElements,gLines,Tendons,Length);
[Points,Neighbours,L,NElements]=mergeQuad(Points,Neighbours,L,NElements,35,36);
drawband(Tendons);
MuscleForces = [0.250*9.8;0.500*9.8;0.250*9.8;0.500*9.8];
Forces=zeros(size(Points));
Forces(15,:)=MuscleForces(1)*(M1-Points(16,:)')/modulus(M1-Points(16,:)');
Forces(16,:)=MuscleForces(2)*(M2-Points(16,:)')/modulus(M2-Points(16,:)');
Forces(17,:)=MuscleForces(3)*(M3-Points(17,:)')/modulus(M3-Points(17,:)');
Forces(18,:)=MuscleForces(4)*(M4-Points(18,:)')/modulus(M4-Points(18,:)');
Points = PointMove(Points,Neighbours,Forces,Param,L);
Tendons2 = iconvTendons(Points,Map);
% figure;
% CreateWindow(Param.currentbonepoints);
% drawband(Tendons2)
% 


