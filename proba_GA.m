clc
clear all
close all

tic

paths = {};
costs = [];
population = 20;
generation = 30;
p_crossover = 0.8;
p_mutation = 0.2;

%prepare the map
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

%%
%obstacles part
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
%%
% A(5,5).appealing = 0;
% A(5,5).repellent = 0;
% 
% A = calculate_euclid_dist_to_goal(A, A(5,5));
% 
% for i = 1 : 20
% A_indexes = zeros(grid_rows,grid_cols);
% [A, A_indexes]= construct_potential_field(A,A_indexes,  A(5,5), grid_rows, grid_cols);
% end

A = calculate_cost(A,  grid_rows, grid_cols, 1, 1);


goal = A(5,5);
start = A(15, 15);

for k = 1 : population
    path = [];
    path = [path, A(15,15)];
    max_value = max([A.cost]);
    new_node = A(15,15);
    node_before = new_node;
    while(true)    
        new_node = roulette_wheel_search(A,new_node,node_before, grid_rows, grid_cols);
        path = [path,new_node];
        node_before = path(length(path)-1);
        if(isequaln(new_node, A(5,5)))
            break
        end
    end 
    paths{k} = path;
    costs = [costs, sum([path.cost])];
end

%%

for gen_ind = 1 : generation
    new_paths = {};
    new_costs = [];
    for pop_ind = 1: round(population/2)
            %sort ascending
            [a_sorted, a_order] = sort(costs);
            paths = paths(a_order);

            sum_of_costs = sum(costs);
            costs_percent = costs/ sum_of_costs;

            choose_parent_1 = rand();
            choose_parent_2 = rand();
            parent1 = [];
            parent2 = [];
            for i = 1:length(costs_percent)
                sum_pare = sum(costs_percent(1:i));
                if(choose_parent_1 <= sum_pare)
                    parent1 = paths{i};
                end

                if(choose_parent_2 <= sum_pare)
                    parent2 = paths{i};
                end
            end

            child_1 =  parent1;
            child_2 =  parent2;

            if (rand() < p_crossover)
                [child_1, child_2] = crossover(A, parent1, parent2);
            end

            if (rand() < p_mutation)
                child_1 = mutate_path(A, goal, child_1, grid_rows, grid_cols);
            end

            if (rand() < p_mutation)
                child_2 = mutate_path(A, goal, child_2, grid_rows, grid_cols);
            end
            
            new_paths{2*(pop_ind-1) +1} = child_1;
            new_costs = [new_costs, sum([child_1.cost])];
            new_paths{2*pop_ind } = child_2;
            new_costs = [new_costs, sum([child_2.cost])];

    end
    [a_sorted, a_order] = sort(new_costs);
    new_paths = new_paths(a_order);
    
    %take 2 best 
    new_costs(end) = costs(1);
    new_costs(end-1) = costs(2);
    new_paths{length(new_costs)} = paths{1};
    new_paths{length(new_costs)-1} = paths{2};
    
    paths = new_paths;
    costs = new_costs;
end
[a_sorted, a_order] = sort(costs);
paths = paths(a_order);
figure();
x_s = [];
y_s = [];
best_path = paths{1};
for i = 1: length(best_path)
    x_s = [x_s, best_path(i).i];
    y_s = [y_s, best_path(i).j];
end

plot(x_s, y_s, 'LineWidth', 5)

hold on;


plot(indexs_obstacle_x, indexs_obstacle_y, 'LineWidth', 5)