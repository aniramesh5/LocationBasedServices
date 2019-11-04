function [H] = calculateH(node,endNode)
%CALCULATEH Summary of this function goes here
%   Detailed explanation goes here

start = [node.Lat; node.Lon];
finish = [endNode.Lat; endNode.Lon];

% length of distance on globe
H = deg2km(distance(node.Lat, node.Lon, endNode.Lat, endNode.Lon))*1000;

% length on projection
%H = sqrt((node.X-endNode.X)*(node.X-endNode.X) + (node.Y-endNode.Y)*(node.Y-endNode.Y)    );

end

