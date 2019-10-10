function main()

tic
%% create worldfile for boston snippet
worldfile= calcWorldfile('./data/fixPoints.csv');
safeWorldfile(worldfile, './data/boston_snippet.pgw');

%% transform shapefile
% transforming NAD83 coordinate (survey feet) to geocoordinates (meter)
[roadsLat, roadsLon] = transformShapeFileToGeocoordinates('boston_roads.shp', 'boston.tif', 'survey feet','meter');

%% ploting maps
figure
axesm('mercator')
geoshow('./data/boston_snippet.png')
geoshow(roadsLat, roadsLon, 'Color', 'blue')

toc 
end