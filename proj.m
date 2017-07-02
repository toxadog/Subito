function ap = proj(a,n)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
n=n./modulus(n);

if getangle(a,n)>pi/2
    ap=a-n.*(modulus(a)*cos(getangle(a,n)));
else
    ap=a;
end

end

