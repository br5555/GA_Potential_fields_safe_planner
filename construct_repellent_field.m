function [A, A_indexes] = construct_repellent_field(Map,Map_indexes, obstacle, grid_rows, grid_cols)

indexes_x = [0,1,0,-1];
indexes_y = [1,0,-1,0];
A_indexes = Map_indexes;
for k = 1:4

    if (((indexes_x(k) + obstacle.i) <= 0) || (indexes_x(k) + obstacle.i > grid_rows) || ((indexes_y(k) + obstacle.j) <= 0) || (indexes_y(k) + obstacle.j > grid_cols))
        continue;
    else
        if (Map(indexes_x(k) + obstacle.i, indexes_y(k) + obstacle.j).obstacle)
            continue;
        end
        if(Map(indexes_x(k) + obstacle.i, indexes_y(k) + obstacle.j).repellent == -1) || (obstacle.repellent -2 >= Map(indexes_x(k) + obstacle.i, indexes_y(k) + obstacle.j).repellent )
            if( obstacle.repellent-2 >= 0)
                Map(indexes_x(k) + obstacle.i, indexes_y(k) + obstacle.j).repellent = obstacle.repellent-2;
            else
                Map(indexes_x(k) + obstacle.i, indexes_y(k) + obstacle.j).repellent = 0;
            end
        end
    end
end

A = Map;
if A_indexes( obstacle.i,  obstacle.j) == 1
    return;
else
    A_indexes( obstacle.i,  obstacle.j) = 1;
end

for k = 1:4
    if (indexes_x(k) + obstacle.i) <= 0 || (indexes_x(k) + obstacle.i > grid_rows) || (indexes_y(k) + obstacle.j) <= 0 || (indexes_y(k) + obstacle.j > grid_cols) || Map(indexes_x(k) + obstacle.i, indexes_y(k) + obstacle.j).obstacle
        continue;
    else
       
         [A, A_indexes] = construct_repellent_field(A,A_indexes, A(indexes_x(k) + obstacle.i, indexes_y(k) + obstacle.j), grid_rows, grid_cols); 
        
    end
   
end

end