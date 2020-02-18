function [MST, tree_id, tree_ids] = mst_kruskal(adjacent, waypoints) % beide adjacent Matrix

% Aus A: Liste aller Kanten mit gewichten
listOfEdges = getListOfEdges(adjacent);
%default Baum ID; dim(Baum_ID) = #Knoten
tree_ids = ones(length(adjacent),1) * -1;
current_tree = 1;
allWaypointsInOneTree = false;

MST = zeros(length(adjacent), length(adjacent), 2);

while ~allWaypointsInOneTree
    if isempty(listOfEdges)
        disp('no solution')
        break;
    end
    edge = listOfEdges(1,:); %row = j, column = i
    listOfEdges(1,:) = [];
    row = edge(1);
    column = edge(2);
    weight = edge(3);
    
    id_row = tree_ids(row);
    id_column = tree_ids(column);
    

    % j keine baum_ID, i schon
    if tree_ids(row) == -1 && tree_ids(column) >= 0
        tree_ids(row) = tree_ids(column);
        MST(row, column, :) = weight;
        MST(column, row, :) = weight;
    elseif tree_ids(column) == -1 && tree_ids(row) >= 0
        tree_ids(column) = tree_ids(row);
        MST(row, column, :) = weight;
        MST(column, row, :) = weight;
    %beide haben schon eine Baum ID
    elseif tree_ids(column)==tree_ids(row) && tree_ids(column) >= 0
        disp('kreis')
    elseif tree_ids(row) ~= tree_ids(column)
        tree_ids(tree_ids == tree_ids(row)) = tree_ids(column);
        MST(row, column, :) = weight;
        MST(column, row, :) = weight;
    else
        tree_ids(row) = current_tree;
        tree_ids(column) = current_tree;
        current_tree = current_tree + 1;

        MST(row, column, :) = [weight, current_tree];
        MST(column, row, :) = [weight, current_tree];
    end
    
    id_row = tree_ids(row);
    id_column = tree_ids(column);
    
    

    [allWaypointsInOneTree, tree_id] = checkWaypointsInOneTree(tree_ids, waypoints);

end % while
end % function

