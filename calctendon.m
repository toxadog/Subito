function [] = calctendon
global  hfor1 hfor2 hfor3 hMCP hPIP hDIP currentbonepoints currenttendon
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

 if ~isnan(str2double(get(hfor1,'String')))
     F1=str2double(get(hfor1,'String'));
 else
     F1=1;
 end; 
if ~isnan(str2double(get(hfor2,'String')))
     F2=str2double(get(hfor2,'String'));
 else
     F2=1;
 end;
 if ~isnan(str2double(get(hfor3,'String')))
    F3=str2double(get(hfor3,'String'));
 else
     F3=1;
 end;
 MuscleForces=[F1;F2;F3];
 MCP=str2double(get(hMCP,'String'))*pi/180;
 PIP=str2double(get(hDIP,'String'))*pi/180;
 DIP=str2double(get(hPIP,'String'))*pi/180;
 bonepoints=BonesConf(DIP,PIP,MCP);
 Tendons = initial(bonepoints);
 currentbonepoints=bonepoints;
 drawfinger(currentbonepoints(:,1:5));
 Tendons2 = TendonIter(Tendons,bonepoints,MuscleForces);
 Tendons2=AddForces(Tendons2);
 currenttendon=Tendons2;
 drawband(currenttendon);


end

