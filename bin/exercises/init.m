function init

%% create worldfile for boston snippet
worldfile=calcWorldfile('./data/passpoints.csv');
safeWorldfile(worldfile, './data/boston_snippet.pgw');

%% transform shapefile
% transforming NAD83 coordinate (survey feet) to geocoordinates (meter)
shapeFile = transformShapeFileToGeocoordinates('boston_roads.shp', 'boston.tif', 'survey feet','meter');
shapewrite(shapeFile,'./data/boston_roads_geocoord.shp');

%% shapefile to adjazenzmatrix exercise 2
[adj_roads, adj_locals, adj_highways] = shapefileToAdjMatrix('./data/boston_roads_geocoord.shp');
save('./data/adj_boston_roads.mat','adj_roads');
save('./data/adj_boston_locals.mat','adj_locals');
save('./data/adj_boston_highways.mat','adj_highways');

end