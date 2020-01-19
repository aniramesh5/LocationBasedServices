function [laplace, success] = removeEdge(laplace, startNode, endNode)
    % removes the edge between start and end node
    if laplace(startNode, endNode) ~= -1
        success = false 
    else
        laplace(startNode, endNode) = 0;
        laplace(endNode, startNode) = 0;

        laplace(endNode, endNode) = 0;
        laplace(startNode, startNode) = 0;
        degree = abs(sum(laplace(startNode,:)));
        laplace(startNode, startNode) = degree;

        degree = abs(sum(laplace(endNode,:)));
        laplace(endNode, endNode) = degree;
        success = true
    end
     
end
