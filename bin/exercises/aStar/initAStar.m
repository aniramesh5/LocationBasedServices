function [allNodes, openNodes, closedNodes] = initAStar(shapefile, adjacent, startNodeIndex)
% in:
% numberOfRoads: the integer number of roads in the shapefile

numberOfNodes = length(adjacent);

closedNodes = [];

openNodes = [startNodeIndex];

allNodes = getNodesFromShapefile(shapefile);

startNode = allNodes(startNodeIndex);
startNode.G = 0;
startNode.Pre = -1;
allNodes(startNodeIndex) = startNode;

end    