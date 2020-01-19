function listOfEdges = getListOfEdges(adjacent)

    listOfEdges = [];
    for row = 1:length(adjacent)
        for column = row+1:length(adjacent)
           if adjacent(row,column) > 0
               listOfEdges = [listOfEdges; [row, column, adjacent(row,column)]];
           end
        end
    end
    listOfEdges = sortrows(listOfEdges, 3);
end
