function aStar()

%% initialize environment
% boundingbox
dataSet = 'boundingBox';
startNodeIndex = 15;
endNodeIndex = 295;

% locals
% dataSet = 'locals';
% startNodeIndex = 300;
% endNodeIndex = 4000;

% highways
dataSet = 'highways';
startNodeIndex = 10;
endNodeIndex = 321;

showStatus = false; % plot the shapefile, open/closed Nodes etc.

adjacentPath = strcat('./adjacent/boston_', dataSet, '.mat');
shapefilePath = strcat('./shapefile/geocoord/boston_', dataSet, '.shp');

load(adjacentPath, 'adjacent');
shapefile = shaperead(shapefilePath, 'UseGeoCoords', true);

noSolution = false;
bestSolutionFound = false;

[allNodes, openNodes, closedNodes] = initAStar(shapefile, adjacent, startNodeIndex);

%% a star loop
tic

while ~noSolution && ~bestSolutionFound
    currentNodeIndex = getBestSuccessor(openNodes, allNodes);
    indexOfCurrentNodeIndexInOpenNodes = find(openNodes == currentNodeIndex);
    
    % move currentNode from openNodes to closedNodes
    openNodes(indexOfCurrentNodeIndexInOpenNodes) = []; % delete current node from openNodes to prevent feedback
    closedNodes = [currentNodeIndex, closedNodes];
    
    if currentNodeIndex == endNodeIndex
        bestSolutionFound = true;
    end
    
    [openNodes, allNodes] = updateOpenNodes(currentNodeIndex, endNodeIndex, openNodes, closedNodes, allNodes, adjacent);
    
    if isempty(openNodes)
        noSolution = true;
    end
    
    if showStatus
        showAStarStatus(openNodes, closedNodes, shapefile, currentNodeIndex, endNodeIndex, startNodeIndex)
    end
end

toc

%% show output

if ~noSolution
    disp("Route found!")
    showAStarStatus(openNodes, closedNodes, shapefile, currentNodeIndex, endNodeIndex, startNodeIndex)
    showFinalRoute(allNodes, endNodeIndex, startNodeIndex, shapefile)
else
    disp("No Solution")
    showAStarStatus(openNodes, closedNodes, shapefile, currentNodeIndex, endNodeIndex, startNodeIndex)
end

end