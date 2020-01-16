function [bestMatchIndex, bestCoordinate] = p2pMatching(latSelected, lonSelected, shapefile)

bestMatchIndex = -1;
shortestDistance = inf;

allNodes = getNodesFromShapefile(shapefile);


numberOfNodes = length(values(allNodes));
for nodeIndex = 1:numberOfNodes 
    lat = allNodes(nodeIndex).Lat;
    lon = allNodes(nodeIndex).Lon;
    
    distanceToNode = deg2km(distance(lat, lon, latSelected, lonSelected));
    
    if distanceToNode < shortestDistance
        bestMatchIndex = nodeIndex;
        shortestDistance = distanceToNode;
        bestCoordinate = [lat, lon];
    end
    
    
end
