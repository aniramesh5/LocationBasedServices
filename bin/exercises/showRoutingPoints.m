function showRoutingPoints(routingPoints, shapefile)


    geoshow(shapefile, 'Color', 'Black');
for point = routingPoints
    
    shape = getShapeFromIndex(point,shapefile);


    geoshow(shape, 'DisplayType', 'point', 'MarkerEdgeColor', 'r', 'Markersize', 15, 'Marker', '.')
end

end