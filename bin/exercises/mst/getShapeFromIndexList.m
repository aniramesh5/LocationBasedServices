function shape = getShapeFromIndexList(list,shapefile)
    shape = [];
    
    for i = 1:length(list)
        index = list(i);
        if(index <= length(shapefile))
            newShape.Lat = shapefile(index).Lat(:);
            newShape.Lon = shapefile(index).Lon(:);
            newShape.Geometry = shapefile(index).Geometry;
        
        else
            newShape.Lat = shapefile(index - length(shapefile)).Lat(:);
            newShape.Lon = shapefile(index - length(shapefile)).Lon(:);
            newShape.Geometry = shapefile(index - length(shapefile)).Geometry;
        end
        shape = [shape; newShape];
    
    end
end