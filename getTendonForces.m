function TendForces = getTendonForces(Points,Param,Penalty,kpen,K,L,Neighbours,Nodes)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
NNodes=length(Nodes);
N=size(Points,1);
TendForces = zeros(N,4);
for i=1:N
    P = Points(i,:);
    if i<=NNodes
        P2=Points(Neighbours(i,1),:);
        TendForces(i,1:3) = (P2-P)*1e-3*K(i,1)*(modulus(P2-P)-L(i,1))/modulus(P2-P);
        TendForces(i,4) = Nodes(i);
    else
        
        [Pnew,Flag] =  pushout(P',Param);
        TendForces(i,1:3) = (P-Pnew')*1e-3*kpen;
        if Penalty(i)
            TendForces(i,1)=TendForces(i,1)+P(1)*1e-3*kpen;
        end
        TendForces(i,4) = Flag;
    end
end
end

