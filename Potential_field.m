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
        s.repellent = -1;
        s.obstacle = false;
        s.distance = 0;
        A(i,j) = s;
    end
end
length_x = length(grid_rows);
length_y = length(grid_cols);
bounder_start = 11;

for k = 1:round(min(length_x, length_y)/2)
    bounder_start = bounder_start -2;
    if(bounder_start < 0)
        bounder_start = 0;
    end

    for l = 1:grid_rows
        for o = 1:grid_cols
            if((l-k)==0 || (o-k) == 0 || (l+k)==(grid_rows+1) || (o+k)==(grid_cols+1))
                A(l,o).repellent = bounder_start;
            end
        end
    end
end


indexs_obstacle_x = [8,8,8,8,8,8, 8, 8] ;
indexs_obstacle_y = [2,3,4,5,6,7, 8,9] ;
for o = 1:length(indexs_obstacle_x)
     A(indexs_obstacle_x(o), indexs_obstacle_y(o)).obstacle = true;
    A(indexs_obstacle_x(o), indexs_obstacle_y(o)).repellent = 10;
end
%define goal
A(5,5).appealing = 0;
A(5,5).repellent = 0;

A = calculate_euclid_dist_to_goal(A, A(5,5));

for i = 1 : 20
A_indexes = zeros(grid_rows,grid_cols);
[A, A_indexes]= construct_potential_field(A,A_indexes,  A(5,5), grid_rows, grid_cols);
end
for o = 1:length(indexs_obstacle_x)
   
    [A, B_indexes] = construct_repellent_field(A, B_indexes,  A(indexs_obstacle_x(o), indexs_obstacle_y(o)), grid_rows, grid_cols);
    B_indexes = zeros(grid_rows,grid_cols);
end

toc
%%
for i = 1:grid_rows
    for j = 1:grid_cols

        Grid(i,j) = A(i,j).appealing;
    end
end

for i = 1:grid_rows
    for j = 1:grid_cols

        Grid_ob(i,j) = A(i,j).repellent;
    end
end

for i = 1:grid_rows
    for j = 1:grid_cols

        Grid_dist(i,j) = A(i,j).distance;
    end
end
Grid_ob(Grid_ob>9) = Grid_ob(Grid_ob>9)*5;

surf(imresize(Grid+Grid_ob,10)) ;
alpha 0.7