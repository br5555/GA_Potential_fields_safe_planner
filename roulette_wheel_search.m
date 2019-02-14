function node_roulette = roulette_wheel_search(Map,node,node_before, grid_rows, grid_cols,max_value, epsilon, lambda);

indexes_x = [0,1,1,1,0,-1,-1,-1];
indexes_y = [1,1,0,-1,-1,-1,0,1];
neigh_cost = [];
neigh = [];
cost_sum = 0;


for k = 1:8
    if (indexes_x(k) + node.i) <= 0 || (indexes_x(k) + node.i > grid_rows) || (indexes_y(k) + node.j) <= 0 || (indexes_y(k) + node.j > grid_cols) || Map(indexes_x(k) + node.i, indexes_y(k) + node.j).obstacle
        continue;
    else
%         lol = path(find([path.i]==(indexes_x(k) + node.i)));
%         
%         if(~isempty(lol(find([lol.j]==indexes_y(k) + node.j))))
%             continue;
%         end
        if((node_before.i == (indexes_x(k) + node.i)) && (node_before.j == (indexes_y(k) + node.j)))
            continue;
        end
        my_cost = epsilon*sqrt(indexes_x(k)^2 + indexes_y(k)^2) + lambda*(Map(indexes_x(k) + node.i, indexes_y(k) + node.j).appealing + Map(indexes_x(k) + node.i, indexes_y(k) + node.j).repellent );
        
        neigh_cost = [neigh_cost,  my_cost];
        neigh = [neigh,   Map(indexes_x(k) + node.i, indexes_y(k) + node.j)];
    end
end
min_value = min(neigh_cost(:));
neigh_cost = neigh_cost-min_value;
max_value = max(neigh_cost(:)) + 1e-9;


neigh_cost = neigh_cost./(max_value);
neigh_cost = exp(-neigh_cost);
cost_sum = sum(neigh_cost(:));
if length(neigh_cost) == 0
    node_roulette = [];
end
r = rand( 1,'double');
for k = 1:length(neigh_cost)
    if(r <= (sum(neigh_cost(1:k)) / cost_sum))
        node_roulette = neigh(k);
        break;
    end
end

end