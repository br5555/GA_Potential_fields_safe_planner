clc 
clear all
close all
tic
grid_rows = 20;
grid_cols = 20;
A_indexes = zeros(grid_rows,grid_cols);
B_indexes = zeros(grid_rows,grid_cols);

%iniitialize potential field
for i = 1:grid_rows
    for j = 1:grid_cols
        s.i = i;
        s.j = j;
        s.appealing = -1;
        s.repellent = 0;
        s.obstacle = false;
        s.distance = 0;
        s.cost = 0;
        A(i,j) = s;
    end
end
length_x = length(grid_rows);
length_y = length(grid_cols);



A(5,5).appealing = 0;
A(5,5).repellent = 0;

A = calculate_euclid_dist_to_goal(A, A(5,5));

for i = 1 : 20
A_indexes = zeros(grid_rows,grid_cols);
[A, A_indexes]= construct_potential_field(A,A_indexes,  A(5,5), grid_rows, grid_cols);
end

A = calculate_cost(A,  grid_rows, grid_cols, 1, 1);
path = [];
path = [path, A(15,15)];
new_node = A(15,15);
while(true)
    new_node = greedy_search(A,new_node, grid_rows, grid_cols);
    path = [path,new_node];
    if(isequaln(new_node, A(5,5)))
        break
    end
end
toc