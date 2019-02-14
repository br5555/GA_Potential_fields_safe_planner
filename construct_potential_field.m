function [A, A_indexes] = construct_potential_field(Map,Map_indexes, goal, grid_rows, grid_cols)

indexes_x = [0,1,0,-1];
indexes_y = [1,0,-1,0];

A_indexes = Map_indexes;
for k = 1:4
    if (indexes_x(k) + goal.i) <= 0 || (indexes_x(k) + goal.i > grid_rows) || (indexes_y(k) + goal.j) <= 0 || (indexes_y(k) + goal.j > grid_cols) || Map(indexes_x(k) + goal.i, indexes_y(k) + goal.j).obstacle
        continue;
    else
        if(Map(indexes_x(k) + goal.i, indexes_y(k) + goal.j).appealing == -1) || ((goal.appealing+2) <= Map(indexes_x(k) + goal.i, indexes_y(k) + goal.j).appealing )

            Map(indexes_x(k) + goal.i, indexes_y(k) + goal.j).appealing = goal.appealing+2;
        end
        
    end
end

A = Map;
if A_indexes( goal.i,  goal.j) == 1
    return;
else
    A_indexes( goal.i,  goal.j) = 1;
end

for k = 1:4
    if (indexes_x(k) + goal.i) <= 0 || (indexes_x(k) + goal.i > grid_rows) || (indexes_y(k) + goal.j) <= 0 || (indexes_y(k) + goal.j > grid_cols ) || Map(indexes_x(k) + goal.i, indexes_y(k) + goal.j).obstacle
        continue;
    else
       
         [A, A_indexes] = construct_potential_field(A,A_indexes, Map(indexes_x(k) + goal.i, indexes_y(k) + goal.j), grid_rows, grid_cols); 
        
    end
   
end

end