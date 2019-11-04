function [allNodes, openNodes, closedNodes] = initAStar(shapefile, adjacent, startNodeIndex)
% in:
% numberOfRoads: the integer number of roads in the shapefile

numberOfNodes = length(adjacent);

closedNodes = [];

openNodes = [startNodeIndex];

allNodes = containers.Map('KeyType', 'double', 'ValueType', 'any');

for indexOfNode = 1:numberOfNodes/2 
    newNode.Lat = shapefile(indexOfNode).Lat(1);
    newNode.Lon = shapefile(indexOfNode).Lon(1);
    newNode.G = realmax('double'); % maxvalue because it will get compared to other values
    newNode.F = realmax('double'); % maxvalue because it will get compared to other values
    newNode.Pre = [];
    newNode.H = [];
    
    allNodes(indexOfNode) = newNode;
end

for indexOfNode = numberOfNodes/2 + 1 : numberOfNodes
    
    indexInShapefile = indexOfNode - numberOfNodes/2;
    
    newNode.Lat = shapefile(indexInShapefile).Lat(end - 1);
    newNode.Lon = shapefile(indexInShapefile).Lon(end - 1);
    newNode.G = realmax('double');
    newNode.F = realmax('double');
    newNode.Pre = [];
    newNode.H = [];
    
    allNodes(indexOfNode) = newNode;
end

startNode = allNodes(startNodeIndex);
startNode.G = 0;
startNode.Pre = -1;
allNodes(startNodeIndex) = startNode;

end    