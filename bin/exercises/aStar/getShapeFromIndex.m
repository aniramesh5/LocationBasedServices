function shape = getShapeFromIndex(list,shapefile)
    shape = [];
    
    for index = list
        
        if(index <= length(shapefile))
            newShape.Lat = shapefile(index).Lat(1);
            newShape.Lon = shapefile(index).Lon(1);
            newShape.Geometry = 'Point';
        
        else
            newShape.Lat = shapefile(index - length(shapefile)).Lat(end - 1);
            newShape.Lon = shapefile(index - length(shapefile)).Lon(end - 1);
            newShape.Geometry = 'Point';
        end
        shape = [shape; newShape];
    
    end

end
