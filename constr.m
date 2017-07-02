function  Points = constr(Points,N,Param)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[d1,d2]=size(Points);
dl=1/Param.pointsdens;
NNeigmax=size(N,2);
Points_new=zeros(size(Points));
for counter=1:25
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
%             D2=sqrt(ones(1,NNeig)*(D1*D1'))';
            D3=(D2-dl)./D2;
            Pnew=P;
            for iN=1:NNeig
                if D3(iN)>0
                    Pnew=Pnew+D1(iN,:)*D3(iN)*0.5;
                end
            end
%             [Pen dir] = penalty(Pnew',Param);
%             depl=(Pen*dir/modulus(dir))';
%             if Pen<0
%                 Pnew=Pnew-depl;
%             end
%             Pnew = pushout(Pnew',Param);
            Points_new(i,:)=Pnew';
                       
        end
end
  Points=Points_new;
end
end


