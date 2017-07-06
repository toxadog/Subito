function Quad = NumQuad(A,B,C,D,dim1,dim2,pos1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
P1=A;
P2=D;
for i=1:dim1 
    Quad(:,:,i)=NumBand(P1,P2,dim2,pos1);
    switch i
        case 1
            P1=pos1+dim2-2;
            P2=P1+dim2-1;
            pos1=pos1+dim2-1;
            
        case dim1-1
            
            P1=B;
            P2=C;
            pos1=pos1+dim2-1;
        otherwise
            P1=pos1+dim2-1;
            P2=P1+dim2-1;
            pos1=pos1+dim2;
            
    end
               
               
end       

end

