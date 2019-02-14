function path = find_path_peer_2_peer_heuristic_2(Map, node1, node2)

path = [node1];
while(true)

    diff_j = node2.j - node1.j;
    diff_i = node2.i - node1.i;
    if( abs(diff_j) > 0) && ( abs(diff_i) > 0) && ~(Map(node1.i + sign(diff_i), node1.j + sign(diff_j)).obstacle)
        
            path = [path, Map(node1.i + sign(diff_i), node1.j + sign(diff_j)) ];
        
    elseif  (abs(diff_i) > 0) && ~(Map(node1.i + sign(diff_i), node1.j).obstacle)
         
            path = [path, Map(node1.i + sign(diff_i), node1.j) ];
            
    elseif (abs(diff_j) > 0) && ~(Map(node1.i , node1.j + sign(diff_j)).obstacle)
         
            path = [path, Map(node1.i , node1.j + sign(diff_j)) ];
        
    
        
    else 
        if( isequaln( node2, node1 ) )
            path = [path, node2];
            return;
        else
            
            path = [];
            
            return;
        end

    end
    node1 = path(end);
    
end

end