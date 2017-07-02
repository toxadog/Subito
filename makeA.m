function [A,B] = makeA(N, delt)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
A=zeros((N+1)*(N+2)/2,N);
B=zeros((N+1)*(N+2)/2);
for count=1:N
    a=zeros(1,N);
    a(count)=delt;
    A(count,:)=a;
    A(count+N,:)=-a;  
end
count=count+N+1;
for i=1:N-1
    for j=i+1:N
        a=zeros(1,N);
        a(i)=delt;
        a(j)=delt;
        A(count,:)=a;
        count=count+1;
    end
end
    
         
for i=1:(N+1)*(N+2)/2
    B(i,:)=quadA(A(i,:));
end;


end
