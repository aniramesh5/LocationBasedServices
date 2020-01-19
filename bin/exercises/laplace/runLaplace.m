function runLaplace()
    dataSet = 'highways';
    adjacentPath = strcat('../adjacent/boston_', dataSet, '.mat');
    adjacent = load(adjacentPath, 'adjacent').adjacent;

    disp('Highway is Korollar')
    laplaceMatrix = calculateLaplaceMatrix(adjacent);
    disp(isKorollar(laplaceMatrix))

    segmentToRemove = 13;
    startNode = segmentToRemove;
    endNode = segmentToRemove + length(laplaceMatrix)/2;

    disp(strcat('Remove Edge between Node ', num2str(startNode), ' and ', num2str(endNode), ' from ', num2str(dataSet)));
    removeEdge(laplaceMatrix, startNode, endNode);

    disp('Is it still Korollar?')
    disp(isKorollar(laplaceMatrix))
   
    dataSet = 'boundingBox';
    adjacentPath = strcat('../adjacent/boston_', dataSet, '.mat');
    adjacent = load(adjacentPath, 'adjacent').adjacent;

    disp('BoundingBox is Korollar')
    laplaceMatrix = calculateLaplaceMatrix(adjacent);
    disp(isKorollar(laplaceMatrix))

    dataSet = 'locals';
    adjacentPath = strcat('../adjacent/boston_', dataSet, '.mat');
    adjacent = load(adjacentPath, 'adjacent').adjacent;

    disp('Locals is Korollar')
    laplaceMatrix = calculateLaplaceMatrix(adjacent);
    disp(isKorollar(laplaceMatrix))

    dataSet = 'original';
    adjacentPath = strcat('../adjacent/boston_', dataSet, '.mat');
    adjacent = load(adjacentPath, 'adjacent').adjacent;

    disp('Original is Korollar')
    laplaceMatrix = calculateLaplaceMatrix(adjacent);
    disp(isKorollar(laplaceMatrix))


    
end

