function node_greedy = greedy_search(Map,node, grid_rows, grid_cols, epsilon, lambda);

indexes_x = [0,1,1,1,0,-1,-1,-1];
indexes_y = [1,1,0,-1,-1,-1,0,1];
best_cost = lambda*(Map( node.i,  node.j).appealing + Map( node.i,  node.j).repellent );
node_greedy = node;

for k = 1:8
    if (indexes_x(k) + node.i) <= 0 || (indexes_x(k) + node.i > grid_rows) || (indexes_y(k) + node.j) <= 0 || (indexes_y(k) + node.j > grid_cols) || Map(indexes_x(k) + node.i, indexes_y(k) + node.j).obstacle
        continue;
    else
        my_cost = epsilon*sqrt(indexes_x(k)^2 + indexes_y(k)^2) + lambda*(Map(indexes_x(k) + node.i, indexes_y(k) + node.j).appealing + Map(indexes_x(k) + node.i, indexes_y(k) + node.j).repellent );
        if best_cost > my_cost
            best_cost =my_cost;
            node_greedy = Map(indexes_x(k) + node.i, indexes_y(k) + node.j);
        end
    end
end

if(isequaln(node_greedy, node))
    while(true)
        k = randi([1 8],1);
        if (indexes_x(k) + node.i) <= 0 || (indexes_x(k) + node.i > grid_rows) || (indexes_y(k) + node.j) <= 0 || (indexes_y(k) + node.j > grid_cols) || Map(indexes_x(k) + node.i, indexes_y(k) + node.j).obstacle
            continue;
        else
            node_greedy = Map(indexes_x(k) + node.i, indexes_y(k) + node.j);
            break;
        end
    end
end

end