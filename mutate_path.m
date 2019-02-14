function path_mutation = mutate_path(Map, goal, path_ch, grid_rows, grid_cols,  epsilon, lambda)

k = randi([1 length(path_ch)]);
path_mutation = path_ch(1:k);
new_node =  path_ch(k);

while(true)

    new_node = greedy_search(Map,new_node, grid_rows, grid_cols,  epsilon, lambda);
    path_mutation = [path_mutation, new_node];
    if(isequaln(new_node, goal))
        break;
    end

end

end