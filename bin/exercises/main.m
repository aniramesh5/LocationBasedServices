function main()

%% ploting maps Exercise 1
figure
%axesm('mercator')
geoshow('./data/boston_snippet.png')
%geoshow([shapeFile.X],[shapeFile.Y], 'Color', 'blue')

boston_roads_geocoord = shaperead('./shapefile/geocoord/boston_original.shp','UseGeoCoords', true);
geoshow(boston_roads_geocoord, 'Color', 'blue')

%% test shapefile with adjacent matrix
addpath('./tests')
load('./adjacent/boston_highways.mat', 'adjacent');

shapefile = shaperead('./shapefile/geocoord/boston_highways.shp', 'UseGeoCoords', true);

testShapeFile(adjacent, shapefile)


%% calculate route with A*

addpath('./aStar')

aStar()

%% calculate connected graph

addpath('./aStar')

calculateConnectedGraph()

%% p2p matching
addpath('./aStar')

% boundingbox
% dataSet = 'boundingBox';

% locals
% dataSet = 'locals';

% highways
dataSet = 'highways';

adjacentPath = strcat('./adjacent/boston_', dataSet, '.mat');
shapefilePath = strcat('./shapefile/geocoord/boston_', dataSet, '.shp');

shapefile = shaperead(shapefilePath, 'UseGeoCoords', true);

disp("Start Point")
[lonStart, latStart] = selectPointFromShapefile(shapefile);
[startNodeIndex, bestCoordinate]= p2pMatching(latStart, lonStart, shapefile);


disp("End Point")
[lonEnd, latEnd] = selectPointFromShapefile(shapefile);
[endNodeIndex, bestCoordinate] = p2pMatching(latEnd, lonEnd, shapefile);


load(adjacentPath, 'adjacent');
aStar(startNodeIndex, endNodeIndex, shapefile, adjacent)

%% astar with locals - highway - locals

% getting shape and adjacent
dataSet = 'highways';
adjacentPath = strcat('./adjacent/boston_', dataSet, '.mat');
shapefilePath = strcat('./shapefile/geocoord/boston_', dataSet, '.shp');
adjacentHighways = load(adjacentPath, 'adjacent').adjacent;
highways = shaperead(shapefilePath, 'UseGeoCoords', true);

dataSet = 'original';
adjacentPath = strcat('./adjacent/boston_', dataSet, '.mat');
shapefilePath = strcat('./shapefile/geocoord/boston_', dataSet, '.shp');
adjacentOriginal = load(adjacentPath, 'adjacent').adjacent;
original = shaperead(shapefilePath, 'UseGeoCoords', true);

% selecting start and end point of complete route
disp("Start Point")
[lonStart, latStart] = selectPointFromShapefile(original);
[startNodeIndex, startBestCoordinate] = p2pMatching(latStart, lonStart, original);

disp("End Point")
[lonEnd, latEnd] = selectPointFromShapefile(original);
[endNodeIndex, endBestCoordinate] = p2pMatching(latEnd, lonEnd, original);


% get Closest highwaynode to start
[startHighwayNodeIndex, startHighwayCoordinate] = p2pMatching(startBestCoordinate(1), startBestCoordinate(2), highways);


% get Closest highwaynode to end
[endHighwayNodeIndex, endHighwayCoordinate] = p2pMatching(endBestCoordinate(1), endBestCoordinate(2), highways);

% get Closest node in original shape file
[startHighwayInOriginalNodeIndex, startHighwayInOriginalCoordinate] = p2pMatching(startHighwayCoordinate(1), startHighwayCoordinate(2), original);

[endHighwayInOriginalNodeIndex, endHighwayInOriginalCoordinate] = p2pMatching(endHighwayCoordinate(1), endHighwayCoordinate(2), original);

routingPoints = [
                 startNodeIndex, ...
                 endNodeIndex, ...
                 startHighwayInOriginalNodeIndex, ...
                 endHighwayInOriginalNodeIndex ...
                 ];

showRoutingPoints(routingPoints, original)

pause(5)

[routeToHighway, wasSuccessfullFromStartToHighway] = aStar(startNodeIndex, startHighwayInOriginalNodeIndex, original, adjacentOriginal);

[routeOnHighway, wasSuccessfullFromStartToHighway] = aStar(startHighwayNodeIndex, endHighwayNodeIndex, highways, adjacentHighways);

[routeToEnd, wasSuccessfullFromStartToHighway] = aStar(endHighwayInOriginalNodeIndex, endNodeIndex, original, adjacentOriginal);

allNodes = getNodesFromShapefile(original);

% show routeToHighway
showFinalRoute(allNodes, startHighwayInOriginalNodeIndex, startNodeIndex, original, routeToHighway)
pause(5)
% show routeOnHighway
showFinalRoute(allNodes, endHighwayNodeIndex, startHighwayNodeIndex, highways, routeOnHighway)
pause(5)
% show routeOnHighway
showFinalRoute(allNodes, endNodeIndex, endHighwayInOriginalNodeIndex, original, routeToEnd)
pause(5)

%% calculate laplace matrix

addpath('./laplace');
runLaplace()

end
