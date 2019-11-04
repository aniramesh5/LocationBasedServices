function showFinalRoute(allNodes, endNodeIndex, startNodeIndex, shapefile)

route = [];

reachedFirstNode = false;
currentNode = endNodeIndex;


while ~reachedFirstNode
    node = allNodes(currentNode);
    preNode = node.Pre;
    if preNode == -1
        reachedFirstNode = true;
    end
    
    shapeOfCurrentNode = getShapeFromIndex(currentNode, shapefile);
    
    route = [shapeOfCurrentNode; route];
    
    currentNode = preNode;
end

endShape = getShapeFromIndex(endNodeIndex,shapefile);
startShape = getShapeFromIndex(startNodeIndex,shapefile);



geoshow(shapefile, 'Color', 'Black');

geoshow(route, 'DisplayType', 'point', 'MarkerEdgeColor', 'm', 'Markersize', 15, 'Marker', '.')
geoshow(endShape, 'DisplayType', 'point', 'MarkerEdgeColor', 'r', 'Markersize', 15, 'Marker', '.')
geoshow(startShape, 'DisplayType', 'point', 'MarkerEdgeColor', 'g', 'Markersize', 15, 'Marker', '.')
end

