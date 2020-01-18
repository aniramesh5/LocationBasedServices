function laplace = laplace(adjacent)


    laplace = zeros(size(adjacent));

    for row = 1:length(adjacent)
        for column = row+1:length(adjacent) % n = m
            if adjacent(row, column) > 0
                laplace(row, column) = -1;
                laplace(column, row) = -1;
            end
        end
    degree = abs(sum(laplace(row,:)));
    laplace(row, row) = degree;
    end
end
