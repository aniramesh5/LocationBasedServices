function outputRoads = transformShapeFileToGeocoordinates(shapeFile, tifFile, unitFrom, unitTo)

    % transforms a shape file from one projection to another and transform the
    % units if needed

    % shapeFile         : File which should be transformed
    % tifFile           : Tif file which contains the projection
    % unitFrom          : the unit which is used in the shape file
    % unitTo            : the unit which should be used in the new shape file

    % getting road data
    roads = shaperead(shapeFile);
    outputRoads = roads;

    % NAD83 proj_param laden 
    info = geotiffinfo(tifFile);

    % getting ration from survey feet to meter
    uRatio = unitsratio(unitFrom,unitTo);

    % calculating road in m
    for roadIndex = 1 : length(roads)

        % calculate the new unit value
        x = roads(roadIndex).X * uRatio;
        y = roads(roadIndex).Y * uRatio;

        boundingBox = roads(roadIndex).BoundingBox * uRatio;

        % write to the new shape file
        [bb1, bb2] = projinv(info, boundingBox(:,1), boundingBox(:,2));
        outputRoads(roadIndex).BoundingBox = [bb1(1), bb2(1); bb1(2), bb2(2)];

        [lat, lon] = projinv(info, x, y);
        outputRoads(roadIndex).Lat = lat;
        outputRoads(roadIndex).Lon = lon;
    end
    
    outputRoads = rmfield(outputRoads,{'X', 'Y'});
end