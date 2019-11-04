function [successors] = getSuccessorIndex(currentNode, adjacent)

% in
% currentNode: the index of node from which the successor should be
% calculated
% adjacent: adjacent matrix

% out:
% list of indices of all successorNodes

adjacentOfCurrentNode = adjacent(currentNode,:);

successors = find(adjacentOfCurrentNode);

end