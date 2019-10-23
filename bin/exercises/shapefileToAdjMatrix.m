function [adj_roads, adj_locals, adj_highways] = shapefileToAdjMatrix(shapefile)
    % in:
    % shapefile         : path to the shapefile
    %
    % out:
    % adj_roads         : adjazenzmatrix of all roads
    % adj_locals        : adjazenzmatrix of all locals
    % adj_highways      : adjazenzmatrix of all highways
    bbox = [-71.09 42.365; -71.08 42.37];

    roads = shaperead(shapefile, 'BoundingBox', bbox);
    %histcounts([roads.CLASS])
    
    locals = shaperead(shapefile, 'Selector', {@(v1) (v1 < 4),'CLASS'}, 'BoundingBox', bbox);
    % histcounts([locals.CLASS])
   
    highways = shaperead(shapefile, 'Selector', {@(v1) (v1 >= 4),'CLASS'}, 'BoundingBox', bbox);
    % histcounts([locals.CLASS])
    
    disp('start calculating adjacent matrix')
    adj_roads = calcAdjMatrix(roads);
    adj_locals = calcAdjMatrix(locals);
    adj_highways = calcAdjMatrix(highways);
    disp('stop calculating adjacent matrix')
    
end