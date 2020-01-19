function allInOneTree = checkWaypointsInOneTree(tree_ids, waypoints)
    firstTreeID = tree_ids(waypoints(1));
    allInOneTree = true;
    currentWaypoint = 2;
    while allInOneTree
        allInOneTree = tree_ids(currentWaypoint) == firstTreeID;
        currentWaypoint = currentWaypoint + 1;
    end
end
