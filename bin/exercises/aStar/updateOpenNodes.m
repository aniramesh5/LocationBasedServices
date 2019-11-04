function [openNodes, allNodes] = updateOpenNodes(currentNodeIndex, endNodeIndex, openNodes, closedNodes, allNodes, adjacent)

% IN: 
% currentNodeIndex: index of currentNode in allNodes
% endNodeIndex: index of endNode in allNodes to check if the node is
% reached
% openNodes: a list of indices of all openNodes (open list)
% closedNodes: a list of indices of all closedNodes (closed list)
% allNodes: a list of all available nodes containing all the data like
% adjacent: the adjacentMatrix

% Out
% openNodes: a updated list of openNodes (open list)
% allNodes: allNodes with new data in the nodes

%%% checks all successor nodes if
%%% - the successor is not in the openList / is not allready known or
%%% - the new way is a better path than the already known ways

successors = getSuccessorIndex(currentNodeIndex, adjacent);

for successorNodeIndex = successors

    successorNode = allNodes(successorNodeIndex);
    successorNodeIsInClosedNodes = ~isempty(find(closedNodes == successorNodeIndex, 1));
    
    if ~successorNodeIsInClosedNodes

        gCurrentNodeSuccessorNode = adjacent(currentNodeIndex, successorNodeIndex);
        tempG = allNodes(currentNodeIndex).G + gCurrentNodeSuccessorNode;
        
        successorNodeIsInOpenNodes = ~isempty(find(openNodes == successorNodeIndex, 1));
        PathToSuccessorIsSet = ~isempty(successorNode.G);
        newPathToSuccessorIsBetter = PathToSuccessorIsSet && tempG <= successorNode.G;
        
        if newPathToSuccessorIsBetter || ~successorNodeIsInOpenNodes
           successorNode.G = tempG;
           successorNode.Pre = currentNodeIndex;
                    
            HforSuccessorNodeIsUnknown = isempty(successorNode.H);
            
            if HforSuccessorNodeIsUnknown
                endNode = allNodes(endNodeIndex);
                successorNode.H = calculateH(successorNode, endNode);
            end
            
            successorNode.F = calculateF(successorNode.G, successorNode.H);
            
            if ~successorNodeIsInOpenNodes
               openNodes = [openNodes, successorNodeIndex];
            end
            
            allNodes(successorNodeIndex) = successorNode;
        end
     end   
end


end