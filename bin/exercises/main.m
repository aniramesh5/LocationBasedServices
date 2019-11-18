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

showStatus = false; % plot the shapefile, open/closed Nodes etc.

adjacentPath = strcat('./adjacent/boston_', dataSet, '.mat');
shapefilePath = strcat('./shapefile/geocoord/boston_', dataSet, '.shp');

shapefile = shaperead(shapefilePath, 'UseGeoCoords', true);

disp("Start Point")
[lonStart, latStart] = selectPointFromShapefile(shapefile);
startNodeIndex = p2pMatching(latStart, lonStart, shapefile);


disp("End Point")
[lonEnd, latEnd] = selectPointFromShapefile(shapefile);
endNodeIndex = p2pMatching(latEnd, lonEnd, shapefile);


load(adjacentPath, 'adjacent');
aStar(startNodeIndex, endNodeIndex, shapefile, adjacent)

end