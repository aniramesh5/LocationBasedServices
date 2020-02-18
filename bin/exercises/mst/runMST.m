function runMST()



    addpath('./adjacent')
    addpath('./shapefile')
    dataSet = 'original';
    adjacentPath = strcat('./adjacent/boston_', dataSet, '.mat');
    adjacent = load(adjacentPath, 'adjacent').adjacent;

    waypoints = [200, 101, 300];

    [MST, tree_id, tree_ids] = mst_kruskal(adjacent, waypoints);
    for i = (1:20)
    [MST, tree_id, tree_ids] = mst_kruskal(MST, waypoints);
    end
    tree_elements = find(tree_ids == tree_id);

    
    shapefilePath = strcat('./shapefile/geocoord/boston_', dataSet, '.shp');
    fullShapefile = shaperead(shapefilePath, 'UseGeoCoords', true);

    waypoints_shape = getShapeFromIndex(waypoints, fullShapefile);
    way_shape = getShapeFromIndexList(tree_elements,fullShapefile);
    
    
    geoshow(fullShapefile, 'Color', 'Black')
    geoshow(waypoints_shape,'Color', 'Red')
    geoshow(way_shape, 'Color', 'Green')


        


end
