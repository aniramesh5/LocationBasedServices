function deadEnds = numberOfDeadEnds(laplace)
    deadEnds = 0;
    for i = 1: length(laplace)
        if laplace(i,i) == 1
            deadEnds = deadEnds + 1;
        end
    end
end
