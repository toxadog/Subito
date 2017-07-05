function [T,N] = convertElement(i,NElements,Nodes,Tendons)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
nN=[find(NElements(:,1)==1,1, 'last');find(NElements(:,1)==2,1, 'last');find(NElements(:,1)==3,1, 'last');...
    find(NElements(:,1)==4,1, 'last');find(NElements(:,1)==5,1, 'last')];


T=zeros(NElements(i,2),3);
N=zeros(NElements(i,2),15);
switch NElements(i,1)
    case 1
        T=Nodes(:,i)';
    case 2
        band=Tendons.(horzcat('n',int2str(i-nN(1))));
        npoints=size(band,2);
        for j=2:npoints-1;
            T(j-1,:)=band(:,j)';
        end
    case 3
        band=Tendons.(horzcat('t',int2str(i-nN(2))));
        npoints=size(band,2);
        for j=2:npoints-1;
            T(j-1,:)=band(:,j)';
        end
    case 4
        grid=Tendons.(horzcat('g',int2str(i-nN(3)))); 
        npoints=size(grid,2);
        for j1=1:size(grid,3) 
            band=grid(:,:,j1);
            for j2=2:npoints-1;   
                T(j2-1+(npoints-2)*(j1-1),:)=band(:,j2)';
            end
        end
    case 5
        grid=Tendons.(horzcat('s',int2str(i-nN(4)))); 
        npoints=size(grid,2);
        for j1=1:size(grid,3) 
            band=grid(:,:,j1);
            if j1==1
                for j2=2:npoints-1;
                    T(j2-1,:)=band(:,j2)';
                end
            else if (j1~=1)&&(j1~=size(grid,3))
                for j2=2:npoints;
                    T(j2-1+(npoints-1)*(j1-1)-1,:)=band(:,j2)';
                end
                else
                    for j2=2:npoints-1;
                        T(j2-1+(npoints-1)*(j1-1)-1,:)=band(:,j2)';
                    end
                end
            end
        end
        case 6
        grid=Tendons.(horzcat('m',int2str(i-nN(4)))); 
        npoints=size(grid,2);
        for j1=1:size(grid,3) 
            band=grid(:,:,j1);
            if j1==1
                for j2=2:npoints-1;
                    T(j2-1,:)=band(:,j2)';
                end
            else if (j1~=1)&&(j1~=size(grid,3))
                for j2=1:npoints;
                    T(j2-1+(npoints)*(j1-1)-2,:)=band(:,j2)';
                end
                else
                    for j2=2:npoints-1;
                        T(j2-1+(npoints)*(j1-1)-2,:)=band(:,j2)';
                    end
                end
            end
        end
end
end


