function Triang = NumTriang(A,B,C,dim1,dim2,pos1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
P=A;
for i=1:dim1 
    Triang(:,:,i)=NumBand(P,C,dim2,pos1);
     if i==( dim1-1)
             P=B;
             pos1=pos1+dim2-2;
     else
            P=pos1+dim2-2;
            pos1=pos1+dim2-1;
         end
     
end

end

