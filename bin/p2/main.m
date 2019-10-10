function main()

%% create worldfile for boston snippet
worldfile= calcWorldfile('./data/fixPoints.csv');

safeWorldfile(worldfile, './data/boston_snippet.pgw');

%% transform shapefile
tic
% transforming NAD83 coordinate (survey feet) to geocoordinates (meter)
[roadsLat, roadsLon] = transformShapeFileToGeocoordinates('boston_roads.shp', 'boston.tif', 'survey feet','meter');
toc

%% ploting maps
geoshow('./data/boston_snippet.png')
geoshow(roadsLat, roadsLon, 'Color', 'green')
end