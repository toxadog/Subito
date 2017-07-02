function [Lline Rline] = getGrid(Points1,Points2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if length(Points2)>length(Points1)
    PointsMax=Points2;
    PointsMin=Points1;
    flag1=1;
else if length(Points1)>length(Points2)
        PointsMax=Points1;
        PointsMin=Points2;
        flag1=2;
    else
        Lline=Points1;
        Rline=Points2;
        flag1=3;
    end
end
        


if (flag1==1)||(flag1==2)
    nmax=length(PointsMax);
    nmin=length(PointsMin);
    x=(2*nmax/nmin-2)/(nmin-1);
    numb=floor(x*(nmin-2)+1:-x:1);
    numb=[nmax-sum(numb) numb];
    Lline=zeros(1,nmax);
    counter=1;
    for i=1:nmin
        for j=1:numb(i)
            Lline(counter)=PointsMin(i);
            counter=counter+1;
        end
    end
    Rline=PointsMax;
    if flag1==2
        Temp=Rline;
        Rline=Lline;
        Lline=Temp;
    end
end

end

