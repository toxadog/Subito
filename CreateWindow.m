function CreateWindow(bonepoints)
global haxes
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
clf;
hF1=gcf;
set(hF1,'Name', 'Tendon','Toolbar','figure', 'PaperPositionMode', 'auto');
haxes=axes( 'Parent', hF1, 'Color', [ 1 1 1],'Units', 'points', 'Units','normalized','Position', [ 0.1 0.1 0.8 0.8 ]);
drawfinger(bonepoints);

