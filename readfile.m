function [hand L Elast TendS] = readfile
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

finger = parseXML('finger.xml');
tendons=parseXML('tendons.xml');
hand=[];
for i=1:3
    for j=1:(size(finger.Children,2)-1)/2
        data=str2double(finger.Children(1,j*2).Children(1,2+i*2).Children.Data);
        if data~=0
            hand=[hand data];
        end
    end
end
L=[];
TendS=[];
Elast=[];
for j=1:(size(tendons.Children,2)-1)/2
        data1=str2double(tendons.Children(1,j*2).Children(1,4).Children.Data);
        data2=str2double(tendons.Children(1,j*2).Children(1,6).Children.Data);
        data3=str2double(tendons.Children(1,j*2).Children(1,8).Children.Data);

        if data1~=0
            L=[L data1];
        end
        if data2~=0
            TendS=[TendS data2];
        end
        if data3~=0
            Elast=[Elast data3];
        end
end

end

