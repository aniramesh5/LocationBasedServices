function tutorial1

ShapeFile1 = 'concord_roads.shp';
ShapeFile2 = 'boston_roads.shp';

% display the road map
roads = shaperead(ShapeFile1);
figure
mapshow(roads);
xlabel('easting in meters')
ylabel('northing in meters')

w = waitforbuttonpress;
clf('reset')
% display the road map with other lineStyle
%figure
mapshow(ShapeFile1,'LineStyle',':');
xlabel('easting in meters')
ylabel('northing in meters')

% Show the attributes of shapefile
type concord_roads.txt

% Querry the attributes of the roads file
roads = shaperead(ShapeFile1)

% Find out how many roads fall in each CLASS.
histcounts([roads.CLASS],'BinLimits',[1 7],'BinMethod','integer')

% Find out how many roads fall in each ADMIN_TYPE.
histcounts([roads.ADMIN_TYPE],'BinLimits',[0 3],'BinMethod','integer') 


w = waitforbuttonpress;
clf('reset')

% Create a SymbolSpec to:
% Color local roads (ADMIN_TYPE=0) black.
% Color state roads (ADMIN_TYPE=3) red.
% Hide very minor roads (CLASS=6).
% Set major or larger roads (CLASS=1-4) with a LineWidth of 2.0.
roadspec = makesymbolspec('Line',...
{'ADMIN_TYPE', 0, 'Color','black'}, ...
{'ADMIN_TYPE', 3, 'Color','red'},...
{'CLASS', 6, 'Visible','off'},...
{'CLASS', [1 4], 'LineWidth', 2});

%figure
mapshow(ShapeFile1,'SymbolSpec',roadspec);
xlabel('easting in meters')
ylabel('northing in meters')



w = waitforbuttonpress;
clf('reset')

%Override a graphics property of the SymbolSpec
roadspec = makesymbolspec('Line',...
{'ADMIN_TYPE',0, 'Color','black'}, ...
{'ADMIN_TYPE',3, 'Color','red'},...
{'CLASS',6, 'Visible','off'},...
{'CLASS',[1 4], 'LineWidth',2});
%figure
mapshow(ShapeFile1,'SymbolSpec',roadspec,'Color','black');
xlabel('easting in meters')
ylabel('northing in meters')

w = waitforbuttonpress;
clf('reset')

% Override default property of the SymbolSpec

roadspec = makesymbolspec('Line',...
{'Default', 'Color','green'}, ...
{'ADMIN_TYPE',0, 'Color','black'}, ...
{'ADMIN_TYPE',3, 'Color','red'},...
{'CLASS',6, 'Visible','off'},...
{'CLASS',[1 4], 'LineWidth',2});
%figure
mapshow(ShapeFile2,'SymbolSpec',roadspec);
xlabel('easting in meters')
ylabel('northing in meters')

w = waitforbuttonpress;
clf('reset')

% Display the Boston GeoTIFF image; includes material (c) GeoEye™, all rights reserved.
%figure
mapshow boston.tif
axis image manual off


w = waitforbuttonpress;


% Read Boston placenames in order to overlay on top of the GeoTIFF image.
S = shaperead('boston_placenames.shp');

surveyFeetPerMeter = unitsratio('sf', 'meter');
for k = 1:numel(S)
S(k).X = surveyFeetPerMeter * S(k).X;
S(k).Y = surveyFeetPerMeter * S(k).Y;
end
%Display the placenames.
text([S.X], [S.Y], {S.NAME}, 'Color', [0 0 0], ...
'BackgroundColor',[0.9 0.9 0],'Clipping','on');

w = waitforbuttonpress;

% Zoom in
xlim([ 772007, 775582])
ylim([2954572, 2956535])


w = waitforbuttonpress;
clf('reset')

% Display a pond with three large islands (feature 14 in the concord_hydro_area shapefile). Note that
% islands are visible in the orthophoto through three "holes" in the pond polygon. Display roads in the same
% figure.

[ortho, cmap] = imread('concord_ortho_w.tif');
R = worldfileread('concord_ortho_w.tfw', 'planar', size(ortho));
%figure
mapshow(ortho, cmap, R)

w = waitforbuttonpress;

%Save map limits used for image
xLimits = xlim;
yLimits = ylim;
pond = shaperead('concord_hydro_area.shp', 'RecordNumbers', 14);
hold on
mapshow(pond, 'FaceColor', [0.3 0.5 1], 'EdgeColor', 'black')
mapshow('concord_roads.shp', 'Color', 'red', 'LineWidth', 1);
xlabel('easting in meters')
ylabel('northing in meters')

w = waitforbuttonpress;
% Restore size

xlim(xLimits)
ylim(yLimits)

w = waitforbuttonpress;
clf('reset')

% View the Mount Washington terrain data as a mesh. The data grid is georeferenced to Universal
% Transverse Mercator (UTM) zone 19.

%figure
h = mapshow('9129CATD.ddf','DisplayType','mesh');
Z = h.ZData;
demcmap(Z)
xlabel('UTM easting in meters')
ylabel('UTM northing in meters')


w = waitforbuttonpress;

% View the Mount Washington terrain data as a 3-D surface. Use the default 3-D view, which shows how
% the range looks from the southwest.
% figure
mapshow('9129CATD.ddf');
demcmap(Z)
view(3);
axis equal;
xlabel('UTM easting in meters')
ylabel('UTM northing in meters')
zlabel('Elevation in feet')


w = waitforbuttonpress;
clf('reset')


% Display the grid and contour lines of Mount Washington and Mount Dartmouth.
% Read the terrain data files.
[Z_W, R_W] = arcgridread('MtWashington-ft.grd');
[Z_D, R_D] = arcgridread('MountDartmouth-ft.grd');

% Display the terrain data as a surface in the z == 0 plane, so that overlying contour lines and labels will be
% visible.
%figure
hold on
mapshow(zeros(size(Z_W)),R_W,'CData',Z_W,'DisplayType','surface')
mapshow(zeros(size(Z_D)),R_D,'CData',Z_D,'DisplayType','surface')
demcmap(Z_W)
xlabel('UTM easting in meters')
ylabel('UTM northing in meters')
axis equal

w = waitforbuttonpress;

%  Overlay black contour lines and labels.
cW = mapshow(Z_W, R_W, 'DisplayType', 'contour', ...
'LineColor', 'black', 'ShowText', 'on');
cD = mapshow(Z_D, R_D, 'DisplayType', 'contour', ...
'LineColor', 'black', 'ShowText', 'on');

%%%%%%%%%%%%%%%%%%%%%% LAST PRESS %%%%%%%%%%%%%%%%%%%%%
w = waitforbuttonpress;
close all

end