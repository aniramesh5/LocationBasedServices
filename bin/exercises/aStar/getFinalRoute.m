function [route] = getFinalRoute(allNodes, endNodeIndex, shapefile)


    

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
end

