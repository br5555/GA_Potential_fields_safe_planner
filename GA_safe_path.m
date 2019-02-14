function best_path = GA_safe_path(generation, population, epsilon, lambda, start, goal, obstacles, p_crossover, p_mutation)
paths = {};
costs = [];


%prepare the map
grid_rows = 15;
grid_cols = 15;
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


indexs_obstacle_x = [] ;
indexs_obstacle_y = [] ;

for k = 1:length(obstacles)
    indexs_obstacle_x = [indexs_obstacle_x, obstacles(k).i];
    indexs_obstacle_y = [indexs_obstacle_y, obstacles(k).j];
end
for o = 1:length(indexs_obstacle_x)
     A(indexs_obstacle_x(o), indexs_obstacle_y(o)).obstacle = true;
    A(indexs_obstacle_x(o), indexs_obstacle_y(o)).repellent = 10;
end
%define goal
A(goal.i,goal.j).appealing = 0;
A(goal.i,goal.j).repellent = 0;

A = calculate_euclid_dist_to_goal(A, A(goal.i,goal.j));

for i = 1 : 20
A_indexes = zeros(grid_rows,grid_cols);
[A, A_indexes]= construct_potential_field(A,A_indexes,  A(goal.i,goal.j), grid_rows, grid_cols);
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


goal = A(goal.i,goal.j);
start = A(start.i,start.j);

max_value = lambda*(max([A.appealing]) + max([A.repellent]));
for k = 1 : population
    tries = 0;
    path = [];
    path = [path, start];
    
    new_node = start;
    node_before = new_node;
    while(true)    
        new_node = roulette_wheel_search(A,new_node,node_before, grid_rows, grid_cols,max_value, epsilon, lambda);
        
        
        
        
        
        if(length(path) > 200)
            path = [];
            tries = tries+1;
            path = [path, start];
            new_node = start;
            node_before = new_node;
            if(tries > 200)
                best_path = [];
                return;
            end
            continue;
        end
        
        if(isempty(new_node) )
            path = [];            
            path = [path, start];
            new_node = start;
            node_before = new_node;           
            continue;
        
        end
        path = [path,new_node];
        node_before = path(length(path)-1);
        if(isequaln(new_node, goal))
            break
        end
    end 
    paths{k} = path;
    cost_path = 0;
    for len_path = 1: length(path)-1
        cost_path =cost_path+  epsilon*sqrt((path(len_path).i - path(len_path+1).i)^2 + (path(len_path).j - path(len_path+1).j)^2 );
    end
    cost_path = cost_path + lambda*( ( sum([path.repellent])+ sum([path.appealing]) )/length(path));
    costs = [costs, cost_path];
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
                child_1 = mutate_path(A, goal, child_1, grid_rows, grid_cols, epsilon, lambda);
            end

            if (rand() < p_mutation)
                child_2 = mutate_path(A, goal, child_2, grid_rows, grid_cols, epsilon, lambda);
            end
            
            new_paths{2*(pop_ind-1) +1} = child_1;
            
            new_paths{2*pop_ind } = child_2;
            
            
            
            cost_path = 0;
            for len_path = 1: length(child_1)-1
                cost_path =cost_path+  epsilon*sqrt((child_1(len_path).i - child_1(len_path+1).i)^2 + (child_1(len_path).j - child_1(len_path+1).j)^2 );
            end
            cost_path = cost_path + lambda*( ( sum([child_1.repellent])+ sum([child_1.appealing]) )/length(child_1));
            new_costs = [new_costs, cost_path];
            
            cost_path = 0;
            for len_path = 1: length(child_2)-1
                cost_path =cost_path+  epsilon*sqrt((child_2(len_path).i - child_2(len_path+1).i)^2 + (child_2(len_path).j - child_2(len_path+1).j)^2 );
            end
            cost_path = cost_path + lambda*( ( sum([child_2.repellent])+ sum([child_2.appealing]) )/length(child_2));
            new_costs = [new_costs, cost_path];
            

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

best_path = paths{1};

end