function [lat, lon] = selectPointFromShapefile(shapefile)
    geoshow(shapefile)

    disp('Select point')
    [lat, lon] = ginput(1);
end

