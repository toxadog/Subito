function P=defineP(dim,L1,L2,ConnectN,g,NElements,N)
P=zeros(dim,2);
P1=ConnectN(L1,2);
P2=ConnectN(L1,3);
P3=ConnectN(L2,2);
P4=ConnectN(L2,3);
for i=1:dim
    if g(1,i)==1
        P(i,1)=P1;
    else if g(1,i)==NElements(N+L1,2)+2
            P(i,1)=P2;
        else
    P(i,1)=g(1,i)-1+N+sum(NElements(N+1:N+L1-1,2));
        end
    end
    if g(2,i)==1
        P(i,2)=P3;
    else if g(2,i)==NElements(N+L2,2)+2
            P(i,2)=P4;
        else
        P(i,2)=g(2,i)-1+N+sum(NElements(N+1:N+L2-1,2));
        end
    end
end
end