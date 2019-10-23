function testShapeFile(adjacent, shapefile)

% detected crossing points
crossingPoints = [];
% the connections between new crossing points
additionalEdges = [];

j = 0;

    numberOfEntries = length(adjacent);
    
    for roadIndex = 1 : numberOfEntries-1 % rows (down)
        for roadIndexForward = roadIndex : numberOfEntries % columns (right)
            
            if roadIndex + numberOfEntries/2 ~= roadIndexForward && adjacent(roadIndex, roadIndexForward) > 0% if not already known edge
                j = j+1;
                if roadIndex <= numberOfEntries/2 % if in upper half of adjacent matrix
                    firstX = shapefile(roadIndex).X(1);
                    firstY = shapefile(roadIndex).Y(1);
                else
                    firstX = shapefile(roadIndex - numberOfEntries/2).X(end - 1);
                    firstY = shapefile(roadIndex - numberOfEntries/2).Y(end - 1);
                end
                           
                firstNewCrossingPoint.long = firstX;
                firstNewCrossingPoint.lat = firstY;
                firstNewCrossingPoint.Geometry = 'Point';
                
                if roadIndexForward <= numberOfEntries/2 % if in upper half of adjacent matrix
                    secondX = shapefile(roadIndexForward).X(1);
                    secondY = shapefile(roadIndexForward).Y(1);
                else
                    secondX = shapefile(roadIndexForward - numberOfEntries/2).X(end - 1);
                    secondY = shapefile(roadIndexForward - numberOfEntries/2).Y(end - 1);
                end
                
                secondNewCrossingPoint.long = secondX;
                secondNewCrossingPoint.lat = secondY;
                secondNewCrossingPoint.Geometry = 'Point';
                
                crossingPoints = [crossingPoints; firstNewCrossingPoint; secondNewCrossingPoint];
               
                nextAdditionalEdge.long = [firstX, secondX];
                nextAdditionalEdge.lat = [firstY, secondY];
                nextAdditionalEdge.Geometry = 'Line';
                
                additionalEdges = [additionalEdges; nextAdditionalEdge];
                
         
            end
        end
    end
    
    j
    
    geoshow(shapefile, 'Color', 'green')
    geoshow(crossingPoints, 'Color', 'red', 'Marker', 'x', 'Markersize', 10)
    geoshow(additionalEdges, 'Color', 'blue')
  
    

end