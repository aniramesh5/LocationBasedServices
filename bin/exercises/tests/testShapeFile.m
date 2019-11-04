function testShapeFile(adjacent, shapefile)

% detected crossing points
crossingPoints = [];
% the connections between new crossing points
additionalEdges = [];

firstPoints = [];

j = 0;

    numberOfEntries = length(adjacent);
    
    for nodeIndex = 1 : numberOfEntries-1 % rows (down)
        for nodeIndexForward = nodeIndex + 1 : numberOfEntries % columns (right)
            if adjacent(nodeIndex, nodeIndexForward) > 0 && (nodeIndex + numberOfEntries/2) ~= nodeIndexForward  % if not already known edge
                
                
                if nodeIndex <= numberOfEntries/2 % if in upper half
                    if nodeIndexForward <= numberOfEntries/2 % if in upper half and left
                        
                        newCrossingStart.Lat = shapefile(nodeIndex).Lat(1);
                        newCrossingStart.Lon = shapefile(nodeIndex).Lon(1);
                        newCrossingStart.Geometry = 'Point';
                        
                        newCrossingEnd.Lat = shapefile(nodeIndexForward).Lat(1);
                        newCrossingEnd.Lon = shapefile(nodeIndexForward).Lon(1);
                        newCrossingEnd.Geometry = 'Point';
                        
                        % creating a new entry in a shape of lines
                        additionalEdge.Lat = [shapefile(nodeIndex).Lat(1), shapefile(nodeIndexForward).Lat(1)];
                        additionalEdge.Lon = [shapefile(nodeIndex).Lon(1), shapefile(nodeIndexForward).Lon(1)];
                        additionalEdge.Geometry = 'Line';
                        
                    else % in upper half and right
                        
                        newCrossingStart.Lat = shapefile(nodeIndex).Lat(1);
                        newCrossingStart.Lon = shapefile(nodeIndex).Lon(1);
                        newCrossingStart.Geometry = 'Point';
                        
                        newCrossingEnd.Lat = shapefile(nodeIndexForward - numberOfEntries/2).Lat(end - 1);
                        newCrossingEnd.Lon = shapefile(nodeIndexForward - numberOfEntries/2).Lon(end - 1);
                        newCrossingEnd.Geometry = 'Point';
                    
                        additionalEdge.Lat = [shapefile(nodeIndex).Lat(1), shapefile(nodeIndexForward  - numberOfEntries/2).Lat(end - 1)];
                        additionalEdge.Lon = [shapefile(nodeIndex).Lon(1), shapefile(nodeIndexForward  - numberOfEntries/2).Lon(end - 1)];
                        additionalEdge.Geometry = 'Line';
                    end
                else % in lower half only right possible
                    
                        newCrossingStart.Lat = shapefile(nodeIndex - numberOfEntries/2).Lat(end - 1);
                        newCrossingStart.Lon = shapefile(nodeIndex - numberOfEntries/2).Lon(end - 1);
                        newCrossingStart.Geometry = 'Point';
                        
                        newCrossingEnd.Lat = shapefile(nodeIndexForward - numberOfEntries/2).Lat(end - 1);
                        newCrossingEnd.Lon = shapefile(nodeIndexForward - numberOfEntries/2).Lon(end - 1);
                        newCrossingEnd.Geometry = 'Point';
                        
                        additionalEdge.Lat = [shapefile(nodeIndex  - numberOfEntries/2).Lat(end - 1), shapefile(nodeIndexForward  - numberOfEntries/2).Lat(end - 1)];
                        additionalEdge.Lon = [shapefile(nodeIndex  - numberOfEntries/2).Lon(end - 1), shapefile(nodeIndexForward  - numberOfEntries/2).Lon(end - 1)];
                        additionalEdge.Geometry = 'Line';
                end
                
                crossingPoints = [crossingPoints; newCrossingStart; newCrossingEnd];
                additionalEdges = [additionalEdges; additionalEdge];
                
                
                
                
                j = j+1;
           
         
            end
        end
    end
    disp('Number of crossings: ')
    disp(j)
    

    
    firstPoints = [];
    lastPoints = [];
    
    % calculate the first and last points of one polyline
    for index = 1:length(shapefile)
        newFirstPoint.Lat = shapefile(index,:).Lat(1);
        newFirstPoint.Lon = shapefile(index,:).Lon(1);
        newFirstPoint.Geometry = 'Point';
        
        firstPoints = [firstPoints; newFirstPoint];
        
        newLastPoint.Lat = shapefile(index,:).Lat(end-1);
        newLastPoint.Lon = shapefile(index,:).Lon(end-1);
        newLastPoint.Geometry = 'Point';
        
        lastPoints = [lastPoints; newLastPoint];
    end
    
    geoshow(shapefile, 'Color', 'green')
    geoshow(crossingPoints, 'Color', 'green', 'Marker', 'o', 'Markersize', 5)
    geoshow(additionalEdges, 'Color', 'blue')
    geoshow(firstPoints, 'Color', 'green', 'Marker', 'x', 'Markersize', 10)
    geoshow(lastPoints, 'Color', 'blue', 'Marker', '+', 'Markersize', 10)
    
  
    

end