function showAStarStatus(open, closed, shapefile, current, endNodeIndex, startNodeIndex)
clf
shapesOfOpenList = getShapeFromIndex(open,shapefile);

shapesOfClosedList = getShapeFromIndex(closed, shapefile);

currentShape = getShapeFromIndex(current, shapefile);

endShape = getShapeFromIndex(endNodeIndex,shapefile);
startShape = getShapeFromIndex(startNodeIndex,shapefile);

% static
geoshow(shapefile, 'Color', 'Black');
geoshow(endShape, 'DisplayType', 'point', 'MarkerEdgeColor', 'r', 'Marker', '*', 'Markersize', 7)
geoshow(startShape, 'DisplayType', 'point', 'MarkerEdgeColor', 'g', 'Marker', '*', 'Markersize', 7)

% dynamic
geoshow(shapesOfOpenList, 'DisplayType', 'point', 'MarkerEdgeColor', 'r', 'Marker', 'o', 'Markersize', 5)
geoshow(shapesOfClosedList, 'DisplayType', 'point', 'MarkerEdgeColor', 'c', 'Marker', 'x', 'Markersize', 5)

geoshow(currentShape, 'DisplayType', 'point', 'MarkerEdgeColor', 'r', 'Markersize', 15, 'Marker', '+')

pause(0.1)

end
