function [route, success] = aStar(startNodeIndex, endNodeIndex, shapefile, adjacent)

%% initialize environment
if nargin == 0

    % boundingbox
    % dataSet = 'boundingBox';
    % startNodeIndex = 15;
    % endNodeIndex = 295;

    % locals
    dataSet = 'locals';
    startNodeIndex = 100;
    endNodeIndex = 2020;
    
    
    dataSet = 'original';
    startNodeIndex = 100;
    endNodeIndex = 2020;

    % highways
%     dataSet = 'highways';
%     startNodeIndex = 10;
%     endNodeIndex = 321;

    adjacentPath = strcat('./adjacent/boston_', dataSet, '.mat');
    shapefilePath = strcat('./shapefile/geocoord/boston_', dataSet, '.shp');

    load(adjacentPath, 'adjacent');
    shapefile = shaperead(shapefilePath, 'UseGeoCoords', true);
end

showStatus = false; % plot the shapefile, open/closed Nodes etc.

videoPath = 'aStar-video.avi';
writerObj = VideoWriter(videoPath);
writerObj.FrameRate = 10;     

open(writerObj);



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
        showAStarStatus(openNodes, closedNodes, shapefile, currentNodeIndex, endNodeIndex, startNodeIndex);
        myFrame = getframe(gcf);
        writeVideo(writerObj, myFrame);
    end
end
close(writerObj)

toc

%% show output

if ~noSolution
    disp("Route found!")
    success = true;
    [route] = getFinalRoute(allNodes, endNodeIndex, shapefile);
else
    disp("No Solution")
    success = false;
    route = [];
end
    showAStarStatus(openNodes, closedNodes, shapefile, currentNodeIndex, endNodeIndex, startNodeIndex);
end
