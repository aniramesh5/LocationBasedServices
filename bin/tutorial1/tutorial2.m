function tutorial2

% The coordinates of the image in the GeoTIFF file, boston.tif, are in a projected coordinate reference
% system. You can determine that by using the geotiffinfo function and examine the PCS and
% Projection field values.
info = geotiffinfo('boston.tif');
disp(info.PCS)
disp(info.Projection)

% The length unit of the coordinates are defined by the UOMLength field in the info structure.
disp(info.UOMLength)

% To import the image and the spatial referencing object, use geotiffread.
[boston, R] = geotiffread('boston.tif');

% You can display the image on a regular MATLAB axes using mapshow, which displays the image and sets
% the axes limits to the limits defined by the referencing object, R. The coordinates, as mentioned above,
% are in US survey foot and are relative to an origin to the southwest of the map, which is why the
% numbers are large. The coordinates are always positive within the zone.

mapshow(boston, R)
axis image
title('Boston')


% Import vector line data from the boston_roads.shp file included with the Mapping Toolbox™ software.
roads = shaperead('boston_roads');

% Convert the coordinates of the raster image from units of US survey foot to meter.
R.XWorldLimits = R.XWorldLimits * unitsratio('m','sf');
R.YWorldLimits = R.YWorldLimits * unitsratio('m','sf');

% Display the raster image and vector data using mapshow.
%figure
w = waitforbuttonpress;
clf('reset')

mapshow(boston, R)
mapshow(roads)
title('Boston and Roads')

% Read a raster image with a worldfile whose coordinates are in latitude and longitude. Use imread to read
% the image and worldfileread to read the worldfile and construct a spatial referencing object.
filename = 'boston_ovr.jpg';
overview = imread(filename);
overviewR = worldfileread(getworldfilename(filename), 'geographic', size(overview));


% To display the overview image and the GeoTIFF image in the same map display, you need to create a
% map display using a Mapping Toolbox™ projection structure containing the projection information for the
% data in the projected coordinate reference system, Massachusetts State Plane Mainland Zone
% coordinate system. To make a map display in this system, you can use the projection information
% contained in the GeoTIFF file. Use the geotiff2mstruct function to construct a Mapping Toolbox™
% projection structure, from the contents of the GeoTIFF information structure. The geotiff2mstruct
% function returns a projection in units of meters. Use the projection structure to define the projection
% parameters for the map display.
mstruct = geotiff2mstruct(info);

% Use the latitude and longitude limits of the Boston overview image.
latlim = overviewR.LatitudeLimits;
lonlim = overviewR.LongitudeLimits;

w = waitforbuttonpress;
close all

% Create a map display by using the projection information stored in the map projection structure and set
% the map latitude and longitude limits. Display the geographic data in the map axes. geoshow projects the
% latitude and longitude coordinates.
figure('Renderer', 'opengl')
ax = axesm(mstruct, 'Grid', 'on',...
'GColor', [.9 .9 .9], ...
'MapLatlimit', latlim, 'MapLonLimit', lonlim, ...
'ParallelLabel', 'on', 'PLabelLocation', .025, 'PlabelMeridian', 'west', ...
'MeridianLabel', 'on', 'MlabelLocation', .05, 'MLabelParallel', 'south', ...
'MLabelRound', -2, 'PLabelRound', -2, ...
'PLineVisible', 'on', 'PLineLocation', .025, ...
'MLineVisible', 'on', 'MlineLocation', .05);
geoshow(overview, overviewR)
axis off
tightmap
title({'Boston and Surrounding Region', 'Geographic Coordinates'})

w = waitforbuttonpress;


% Since the coordinates of the GeoTIFF image are in a projected coordinate reference system, use
% mapshow to overlay the more detailed Boston image onto the display. Plot the boundaries of the Boston
% image in red.
mapshow(boston, R)
plot(R.XWorldLimits([1 1 2 2 1]), R.YWorldLimits([1 2 2 1 1]), 'Color', 'red')
title({'Boston and Surrounding Region', 'Geographic and Projected Coordinates'})


% Zoom to the geographic region of the GeoTIFF image by setting the axes limits to the limits of the Boston
% image and add a small buffer. Note that the buffer size (delta) is expressed in meters.
delta = 1000;
xLimits = R.XWorldLimits + [-delta delta];
yLimits = R.YWorldLimits + [-delta delta];
xlim(ax,xLimits)
ylim(ax,yLimits)
setm(ax, 'Grid', 'off');

w = waitforbuttonpress;

roadColors = makesymbolspec('Line',...
{'CLASS', 2, 'Color', 'k'}, ...
{'CLASS', 3, 'Color', 'g'},...
{'CLASS', 4, 'Color', 'magenta'}, ...
{'CLASS', 5, 'Color', 'cyan'}, ...
{'CLASS', 6, 'Color', 'b'},...
{'Default', 'Color', 'k'});
mapshow(roads, 'SymbolSpec', roadColors)
title({'Boston and Surrounding Region','Including Boston Roads'})

w = waitforbuttonpress;

placenames = gpxread('boston_placenames')

% Overlay the placenames onto the map and increase the marker size, change the markers to circles and
% set their edge and face colors to yellow.
geoshow(placenames, 'Marker','o', 'MarkerSize', 6, ...
'MarkerEdgeColor', 'y', 'MarkerFaceColor','y')
title({'Boston and Surrounding Region','Including Boston Roads and Placenames'})


%%%%%%%%%%%%%%%%%%%%%% LAST PRESS %%%%%%%%%%%%%%%%%%%%%
w = waitforbuttonpress;
close all

end