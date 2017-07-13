function  [Points D] = constr(Points,N,Param,L)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[d1,d2]=size(Points);
dl=1/Param.pointsdens;
NNeigmax=size(N,2);
Points_new=Points;
MaxIter=50;
D=zeros(1,MaxIter);
for counter=1:MaxIter
    NP=0;
for i=5:d1
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
            D3=(D2-L(i,1:NNeig)')./D2;
            disp=D2-L(i,1:NNeig)';
            disp=mean(disp(disp>0));
            if ~isnan(disp)
                D(counter)=D(counter)+mean(disp(disp>0));
            end
            NP=NP+1;
            Pnew=P;
            for iN=1:NNeig
                if D3(iN)>0
                    Pnew=Pnew+D1(iN,:)*D3(iN)*0.5/length(D3(D3>0));
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
  Points(5:size(Points,1),:)=Points_new(5:size(Points,1),:);
  D(counter)=D(counter)/NP;
end
end


