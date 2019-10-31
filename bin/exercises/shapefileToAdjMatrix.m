function adjacent = shapefileToAdjMatrix(shapefile)
    % in:
    % shapefile         : path to the shapefile
    %
    % out:
    % adjacent matrix for given shapefile

    shapefile = shaperead(shapefile);
    %histcounts([roads.CLASS])
    
    disp('start calculating adjacent matrix')
    adjacent = calcAdjMatrix(shapefile);
    disp('stop calculating adjacent matrix')
    
end