function [roadsLat, roadsLon] = transformShapeFileToGeocoordinates(shapeFile, tifFile, unitFrom, unitTo)

% getting road data
roads = shaperead(shapeFile);

% NAD83 proj_param laden 
info = geotiffinfo(tifFile);

% getting ration from survey feet to meter
uRatio = unitsratio(unitFrom,unitTo);

% calculating road in m
x = [roads.X] * uRatio;
y = [roads.Y] * uRatio;

% projection to geocoordinates
[roadsLat, roadsLon] = projinv(info, x, y);

% now we are in geocoord
end