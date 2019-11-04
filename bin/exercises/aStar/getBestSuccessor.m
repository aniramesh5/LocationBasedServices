function [indexOfBestSuccessor] = getBestSuccessor(openNodes, allNodes)
%GETBESTSUCCESSOR Summary of this function goes here
%   Detailed explanation goes here

bestF = allNodes(openNodes(1)).F;
indexOfBestSuccessor = openNodes(1);

for nodeIndex = openNodes
    node = allNodes(nodeIndex);
    
    if node.F < bestF
        bestF = node.F;
        indexOfBestSuccessor = nodeIndex;
    end

end
end

