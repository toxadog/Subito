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
JAngles=[0*pi/180,-20*pi/180,-30*pi/180];
Param.currentbonepoints=BonesConf(JAngles(1),JAngles(2),JAngles(3),Param);
CreateWindow(Param.currentbonepoints);
[Tendons Nodes gLines]=initial(Param);
[Points Neighbours]=convTendons(Tendons, Nodes, gLines);
drawband(Tendons)


