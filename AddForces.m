function IntForces = AddForces(Points,N,L,k)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

[d1,~]=size(Points);
NNeigmax=size(N,2);
IntForces=NaN(size(N));
for i=1:d1
 pos0=find(N(i,:)==0);
        if isempty(pos0)
            NNeig=NNeigmax;
        else
            NNeig=pos0(1)-1;
        end
        if NNeig~=0
            Neighbours=zeros(NNeig,3);
            for counter2 = 1:NNeig
                    Neighbours(counter2,:)=Points(N(i,counter2),:);
            end
            P = Points(i,:);
            D1=Neighbours-ones(NNeig,3)*diag(P);
            D2=sqrt(sum(D1.^2,2));
            disp=D2-L(i,1:NNeig)';
            mask=maskneg(disp);
            IntForces(i,1:NNeig)=k*disp'.*mask'/1000;
        end

end
end

function mask= maskneg(x)
mask=sign(abs(x)).*sign(sign(x)+1);
end
