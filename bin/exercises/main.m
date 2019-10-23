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
load('./data/adj_boston_roads.mat', 'adj_roads');


bbox = [-71.09 42.365; -71.08 42.37];

shapefile = shaperead('./data/boston_roads_geocoord.shp', 'BoundingBox', bbox);

testShapeFile(adj_roads, shapefile)

end