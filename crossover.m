function [child_1, child_2] = crossover(Map, parent_1, parent_2)
child_1  = parent_1;
child_2 = parent_2;
parent_1_i = [];
parent_1_j = [];
parent_2_i = [];
parent_2_j = [];

for i = 1:length(parent_1)
    parent_1_i = [parent_1_i, parent_1(i).i];
    parent_1_j = [parent_1_j, parent_1(i).j];
end

for i = 1:length(parent_2)
    parent_2_i = [parent_2_i, parent_2(i).i];
    parent_2_j = [parent_2_j, parent_2(i).j];
end

%remove start and goal position
parent_1_i = parent_1_i(2:end-1);
parent_1_j = parent_1_j(2:end-1);
parent_2_i = parent_2_i(2:end-1);
parent_2_j = parent_2_j(2:end-1);


array_intersect = intersect(parent_1_i, parent_2_i);

index_1_j = -1;
index_2_j = -1;


while( length(array_intersect) >0)
    %choose random point
    i = randi([ 1, length(array_intersect) ]);
    i_p1_index = find(parent_1_i == array_intersect(i));
    i_p2_index = find(parent_2_i == array_intersect(i));
    parent_1_j_for_value = parent_1_j(i_p1_index);
    parent_2_j_for_value = parent_2_j(i_p2_index);
    flage_exit = 0;
    for k = 1:length(parent_1_j_for_value)
        for o = 1:length(parent_2_j_for_value)
            difference = abs( parent_1_j_for_value(k) - parent_2_j_for_value(o));

        if  difference <= 2
            index_1_j =  i_p1_index(k);    %parent_1_j( find( parent_1_j == parent_1_j_for_value(k) ) ) 
            index_2_j =  i_p2_index(o);%parent_2_j( find( parent_2_j == parent_2_j_for_value(o) ) )
            %exit for loops
            k = length( parent_1_j_for_value ) + 100;
            o = length( parent_2_j_for_value ) + 100;
            flage_exit =1;
            break;
        end
    
    
        end
        if(flage_exit)
            break;
        end
    end
    
    %remove searched element
    array_intersect( array_intersect==array_intersect(i) ) = [];
    
    if ~(index_1_j == -1)
        path_child1 = find_path_peer_2_peer(Map, parent_1(index_1_j), parent_2(index_2_j+1));
        path_child2 = find_path_peer_2_peer(Map, parent_2(index_2_j), parent_1(index_1_j+1));
        
        if(isempty(path_child1) || isempty(path_child2))
            continue;
        end
        
        child_1 = [parent_1(1:index_1_j), path_child1(2:end-1), parent_2(index_2_j+1:end)];
        child_2 = [parent_2(1:index_2_j), path_child2(2:end-1), parent_1(index_1_j+1:end)];

        return;
    end
    

end



if isempty(array_intersect)
    child_1 = parent_1;
    child_2 = parent_2;
    return;
end


end