function main()

%% ploting maps Exercise 1
figure
%axesm('mercator')
geoshow('./data/boston_snippet.png')
%geoshow([shapeFile.X],[shapeFile.Y], 'Color', 'blue')

boston_roads_geocoord = shaperead('./data/boston_roads_geocoord.shp','UseGeoCoords', true)
geoshow(boston_roads_geocoord, 'Color', 'blue') 

%% test shapefile with adjacent matrix
addpath('./tests')
load('./adjacent/boston_highways.mat', 'adjacent');

shapefile = shaperead('./shapefile/geocoord/boston_highways.shp', 'UseGeoCoords', true);

testShapeFile(adjacent, shapefile)

end