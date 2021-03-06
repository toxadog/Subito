function T = convertElement(pos,NElements,Nodes,Tendons)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
nN=zeros(5,1);
for i=1:5
    nelem=find(NElements(:,1)==i,1, 'last');
    if ~isempty(nelem)
        nN(i)=nelem;
    else
        nN(i)=nN(i-1);
    end
end
T=zeros(NElements(pos,2),3);
switch NElements(pos,1)
    case 1
        T=Nodes(:,pos)';
    case 2
        band=Tendons.(horzcat('n',int2str(pos-nN(1))));
        npoints=size(band,2);
        for j=2:npoints-1;
            T(j-1,:)=band(:,j)';
        end
    case 3
        band=Tendons.(horzcat('t',int2str(pos-nN(2))));
        npoints=size(band,2);
        for j=2:npoints-1;
            T(j-1,:)=band(:,j)';
        end
    case 4
        grid=Tendons.(horzcat('g',int2str(pos-nN(3)))); 
        npoints=size(grid,2);
        for j1=1:size(grid,3) 
            band=grid(:,:,j1);
            for j2=2:npoints-1;   
                T(j2-1+(npoints-2)*(j1-1),:)=band(:,j2)';
            end
        end
    case 5
        grid=Tendons.(horzcat('s',int2str(pos-nN(4)))); 
        T=convertTriang(grid);
        case 6
        grid=Tendons.(horzcat('m',int2str(pos-nN(5)))); 
        T=convertQuad(grid);
end
end
function T=convertTriang(grid)
dim1=size(grid,3);
dim2=size(grid,2);
T=zeros(dim1*(dim2-1)-2,3);

for j1=1:dim1
    band=grid(:,:,j1);
    switch j1
        case 1
            for j2=2:dim2-1;
                num = j2-1;
                T(num,:)=band(:,j2)';
            end
        case dim1
            for j2=2:dim2-1;
                num = (dim1-1)*(dim2-1)-1+j2-1;
                T(num,:)=band(:,j2)';
            end
        otherwise
            for j2=1:dim2-1;
                num = (j1-1)*(dim2-1)-1+j2;
                T(num,:)=band(:,j2)';
            end
    end 
end
end


function T=convertQuad(grid)
dim1=size(grid,3);
dim2=size(grid,2);
T=zeros(dim1*dim2-4,3);

for j1=1:dim1
    band=grid(:,:,j1);
    switch j1
        case 1
            for j2=2:dim2-1;
                num = j2-1;
                T(num,:)=band(:,j2)';
            end
        case dim1
            for j2=2:dim2-1;
                num = (dim1-1)*dim2-2+j2-1;
                T(num,:)=band(:,j2)';
            end
        otherwise
            for j2=1:dim2;
                num = (j1-1)*dim2-2+j2;
                T(num,:)=band(:,j2)';
            end
    end 
end
end
