function M = getJointTorques(Joints, Points, TendonForces)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
Njoints=size(Joints,2);
Nforces=size(TendonForces,1);
M=zeros(size(Joints));
for i=1:Njoints
    JointPoint = Joints(1,i).JointPoint;
    JointAxe = Joints(1,i).JointAxe;
    NBone = Joints(1,i).NBone; 
    for j=1:Nforces
        if TendonForces(j,4)>NBone
            M(i)=M(i)+getmoment(JointPoint, JointAxe, Points(j,:), TendonForces(j,1:3));
        end
    end

end
end

function m = getmoment(JointPoint, JointAxe, ForcePoint, Force)
    R=(ForcePoint-JointPoint)*1e-3;
    mtotal = cross(Force,R);
    m=mtotal.*JointAxe;
    m=m(m~=0);
end
