function angle = getangle(a,b)
%getangle.m
%Calulates angle between two vectors
% angle=acos(sum(a.*b)/(modulus(a)*modulus(b)));
angle=atan2(norm(cross(a,b)),dot(a,b));
end

