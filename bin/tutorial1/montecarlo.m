function montecarlo
format long g

tic
total = 10000000;

smallerOne = 0;

table = rand(total,2);
table = table.*table;
table = table(:,1) + table(:,2);


for i = 1 : total
       
    if table(i) <= 1
        smallerOne = smallerOne + 1;
    end
end

pi = (smallerOne/total) * 4

toc
end