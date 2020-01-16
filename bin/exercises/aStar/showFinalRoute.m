function showFinalRoute(allNodes, endNodeIndex, startNodeIndex, shapefile, route)

if isempty(route)
    [route] = getFinalRoute(allNodes, endNodeIndex, shapefile);
end

endShape = getShapeFromIndex(endNodeIndex,shapefile);
startShape = getShapeFromIndex(startNodeIndex,shapefile);

geoshow(shapefile, 'Color', 'Black');

geoshow(route, 'DisplayType', 'point', 'MarkerEdgeColor', 'm', 'Markersize', 15, 'Marker', '.')
geoshow(endShape, 'DisplayType', 'point', 'MarkerEdgeColor', 'r', 'Markersize', 15, 'Marker', '.')
geoshow(startShape, 'DisplayType', 'point', 'MarkerEdgeColor', 'g', 'Markersize', 15, 'Marker', '.')
end

