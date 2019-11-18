function allNodes = getNodesFromShapefile(shapefile)
allNodes = containers.Map('KeyType', 'double', 'ValueType', 'any');
numberOfShapes = length(shapefile);

for indexOfNode = 1:numberOfShapes
    newNode.Lat = shapefile(indexOfNode).Lat(1);
    newNode.Lon = shapefile(indexOfNode).Lon(1);
    newNode.G = inf; % maxvalue because it will get compared to other values
    newNode.F = inf; % maxvalue because it will get compared to other values
    newNode.Pre = [];
    newNode.H = [];
    
    allNodes(indexOfNode) = newNode;
end

for indexOfNode = numberOfShapes + 1 : numberOfShapes * 2
    
    indexInShapefile = indexOfNode - numberOfShapes;
    
    newNode.Lat = shapefile(indexInShapefile).Lat(end - 1);
    newNode.Lon = shapefile(indexInShapefile).Lon(end - 1);
    newNode.G = inf;
    newNode.F = inf;
    newNode.Pre = [];
    newNode.H = [];
    
    allNodes(indexOfNode) = newNode;
end
end

