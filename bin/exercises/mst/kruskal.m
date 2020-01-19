function MST = mst_kruskal(adjacent, waypoints) % beide adjacent Matrix

% Aus A: Liste aller Kanten mit gewichten
listOfEdges = getListOfEdges(adjacent);
%default Baum ID; dim(Baum_ID) = #Knoten
tree_ids = ones(length(A),1) * -1
current_tree = 1;
allWaypointsInOneTree = false;
while ~allWaypointsInOneTree
    if length(listOfEdges) == 0
        break;
    [row, column, weight] = listOfEdges(1,:); %row = j, column = i
    listOfEdges(1,:) = [];
    % j keine baum_ID, i schon
    if tree_ids[row] == -1 && tree_ids[column] >= 0
        tree_ids[row] = tree_ids[column];
        MST(row, column) = [weight, current_tree];
        MST(column, row) = [weight, current_tree];
    else if Baum_ID[column] == -1 && Baum_ID[row] >= 0
        tree_ids[column] = tree_ids[row];
        MST(row, column) = [weight, current_tree];
        MST(column, row) = [weight, current_tree];
    %beide haben schon eine Baum ID
    else if tree_ids[column]==tree_ids[row] && tree_ids[column] >= 0
        disp('kreis')
    else if tree_ids[row] != tree_ids[column]
        tree_ids(tree_ids == row) = tree_ids(column);
        MST(row, column) = [weight, current_tree];
        MST(column, row) = [weight, current_tree];
    else
        tree_ids(tree_ids == row) = tree_ids(column);
        Baum_ID[i] = Baum_ID[j] = nex_ID++;
        tree_ids[row] = [current_tree, current_tree];
        tree_ids[column] = [current_tree, current_tree];
        current_tree = current_tree + 1;

        MST(row, column) = [weight, current_tree];
        MST(column, row) = [weight, current_tree];
    end

    allWaypointsInOneTree = checkWaypointsInOneTree(tree_ids, waypoints);
end
end

