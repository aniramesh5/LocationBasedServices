function [allInOneTree, firstTreeID] = checkWaypointsInOneTree(tree_ids, waypoints)
    
    firstTreeID = tree_ids(waypoints(1));
    allInOneTree = false;
    
    if firstTreeID ~= -1
    allInOneTree = true;

        for index = 2:length(waypoints)
            waypoint = waypoints(index);
            waypoint_tree_id = tree_ids(waypoint);
            allInOneTree = waypoint_tree_id == firstTreeID && allInOneTree;
            
        end
    end
end
