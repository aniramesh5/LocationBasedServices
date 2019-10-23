function adjacent = calcAdjMatrix(roads)

numberOfRoads = length(roads);

treshold = 0.0009;

startAndEndPoints = zeros(2 * numberOfRoads, 2);
adjacent = zeros(2*numberOfRoads);

for roadIndex = 1 : numberOfRoads
    
    startPoint = [roads(roadIndex).X(1), roads(roadIndex).Y(1)];
    endPoint = [roads(roadIndex).X(end-1), roads(roadIndex).Y(end-1)];
    
    startAndEndPoints(roadIndex,:) = startPoint;
    startAndEndPoints(roadIndex+numberOfRoads,:) = endPoint;
    
    edgeSize = norm(startPoint - endPoint);
    
    weight = calcWeights(edgeSize);
    adjacent(roadIndex, roadIndex + numberOfRoads) = weight;
    adjacent(roadIndex + numberOfRoads, roadIndex) = weight;
    
end

i = 0;
    for edge = 1 : length(startAndEndPoints) - 1
        for edgeForward = edge+1 : length(startAndEndPoints)
            
            diffPoints = norm(startAndEndPoints(edge,:) - startAndEndPoints(edgeForward,:));
            
            if diffPoints < treshold
                i = i + 1;
               
                adjacent(edgeForward, edge) = diffPoints;
                adjacent(edge, edgeForward) = diffPoints;
                
            end
        end
    end
i    
end
