function calculateConnectedGraph(startNodeIndex, shapefile, adjacent)

%% initialize environment
if nargin == 0

    % boundingbox
    % dataSet = 'boundingBox';
    % startNodeIndex = 15;

    % locals
    % dataSet = 'locals';
    % startNodeIndex = 300;

    % highways
    dataSet = 'highways';
    startNodeIndex = 10;

    adjacentPath = strcat('./adjacent/boston_', dataSet, '.mat');
    shapefilePath = strcat('./shapefile/geocoord/boston_', dataSet, '.shp');

    load(adjacentPath, 'adjacent');
    shapefile = shaperead(shapefilePath, 'UseGeoCoords', true);
end

showStatus = false; % plot the shapefile, open/closed Nodes etc.

nodesLeft = false;

[allNodes, openNodes, closedNodes] = initAStar(shapefile, adjacent, startNodeIndex);

%% a star loop
tic

while ~nodesLeft
    currentNodeIndex = getBestSuccessor(openNodes, allNodes);
    indexOfCurrentNodeIndexInOpenNodes = find(openNodes == currentNodeIndex);
    
    % move currentNode from openNodes to closedNodes
    openNodes(indexOfCurrentNodeIndexInOpenNodes) = []; % delete current node from openNodes to prevent feedback
    closedNodes = [currentNodeIndex, closedNodes];
    
    [openNodes, allNodes] = updateOpenNodes(currentNodeIndex, startNodeIndex, openNodes, closedNodes, allNodes, adjacent);
    
    if isempty(openNodes)
        nodesLeft = true;
    end
    
    if showStatus
        showAStarStatus(openNodes, closedNodes, shapefile, currentNodeIndex, startNodeIndex, startNodeIndex)
    end
end

toc

%% show output

connectedGraphIndex = mod(closedNodes-1, length(shapefile))+1;

connectedGraph = shapefile(connectedGraphIndex);
geoshow(shapefile, 'Color', 'Black');
geoshow(connectedGraph, 'Color', 'Green')


end