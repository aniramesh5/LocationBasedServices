function adjacent = calcAdjMatrix(shapefile)

numberOfRoads = length(shapefile);

treshold = 10;

startAndEndPoints = zeros(2 * numberOfRoads, 2);
adjacent = zeros(2*numberOfRoads);

for roadIndex = 1 : numberOfRoads
    
    startPoint = [shapefile(roadIndex).X(1), shapefile(roadIndex).Y(1)];
    endPoint = [shapefile(roadIndex).X(end-1), shapefile(roadIndex).Y(end-1)];
    
    startAndEndPoints(roadIndex,:) = startPoint;
    startAndEndPoints(roadIndex+numberOfRoads,:) = endPoint;
    
    edgeSize = shapefile(roadIndex).LENGTH;
    
    weight = calcWeights(edgeSize);
    adjacent(roadIndex, roadIndex + numberOfRoads) = weight;
    adjacent(roadIndex + numberOfRoads, roadIndex) = weight;
    
end

i = 0;
    for edge = 1 : length(startAndEndPoints) - 1
        for edgeForward = edge+1 : length(startAndEndPoints)
            
            
            diffPoints = norm(startAndEndPoints(edge,:) - startAndEndPoints(edgeForward,:));
            
            if diffPoints < treshold && (edge + numberOfRoads) ~= edgeForward
                i = i + 1;
               
                adjacent(edgeForward, edge) = 1;
                adjacent(edge, edgeForward) = 1;
                
            end
        end
    end
disp('Number of crossings:')
disp(i)
end
