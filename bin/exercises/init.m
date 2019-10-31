function init

%% create worldfile for boston snippet
worldfile=calcWorldfile('./data/passpoints.csv');
safeWorldfile(worldfile, './data/boston_snippet.pgw');



%% split shape file

shapefileName = "boston";

boundingBox = [233800, 901800; 235000, 902400];

shapefile_boundingBox = shaperead(strcat(shapefileName, '_original.shp'), 'BoundingBox', boundingBox, 'UseGeoCoords', true);
shapewrite(shapefile_boundingBox, strcat('./shapefile/original/', shapefileName, '_boundingBox.shp'));

shapefile_locals = shaperead(strcat(shapefileName, '_original.shp'), 'Selector', {@(v1) (v1 >= 4),'CLASS'}, 'UseGeoCoords', true);
shapewrite(shapefile_locals, strcat('./shapefile/original/', shapefileName, '_locals.shp')');

shapefile_highways = shaperead(strcat(shapefileName, '_original.shp'), 'Selector', {@(v1) (v1 < 4),'CLASS'}, 'UseGeoCoords', true);
shapewrite(shapefile_highways, strcat('./shapefile/original/', shapefileName, '_highways.shp'));

%% transform shapefile exercise 1

shapefileName = "boston";

% transforming NAD83 coordinate (survey feet) to geocoordinates (meter)
shapeFile = transformShapeFileToGeocoordinates(strcat('./shapefile/original/',shapefileName, '_boundingBox.shp'), 'boston.tif', 'survey feet','meter');
shapewrite(shapeFile, strcat('./shapefile/geocoord/',shapefileName, '_boundingBox.shp'));

shapeFile = transformShapeFileToGeocoordinates(strcat('./shapefile/original/',shapefileName, '_highways.shp'), 'boston.tif', 'survey feet','meter');
shapewrite(shapeFile, strcat('./shapefile/geocoord/',shapefileName, '_highways.shp'));

shapeFile = transformShapeFileToGeocoordinates(strcat('./shapefile/original/',shapefileName, '_locals.shp'), 'boston.tif', 'survey feet','meter');
shapewrite(shapeFile, strcat('./shapefile/geocoord/',shapefileName, '_locals.shp'));

%% shapefile to adjazenzmatrix exercise 2

shapefileName = "boston";

adjacent = shapefileToAdjMatrix(strcat('./shapefile/original/',shapefileName, '_boundingBox.shp'));
save(strcat('./adjacent/',shapefileName, '_boundingBox.mat'), 'adjacent');

adjacent = shapefileToAdjMatrix(strcat('./shapefile/original/',shapefileName, '_highways.shp'));
save(strcat('./adjacent/',shapefileName, '_highways.mat'), 'adjacent');

adjacent = shapefileToAdjMatrix(strcat('./shapefile/original/',shapefileName, '_locals.shp'));
save(strcat('./adjacent/',shapefileName, '_locals.mat'), 'adjacent');

addpath('./tests')
load('./adjacent/boston_highways.mat', 'adjacent');

shapefile = shaperead('./shapefile/geocoord/boston_highways.shp', 'UseGeoCoords', true);

testShapeFile(adjacent, shapefile)
end