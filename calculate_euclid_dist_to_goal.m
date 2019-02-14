function Map = calculate_euclid_dist_to_goal(A, goal)
for k = 1:size(A,1)
    for j = 1:size(A,2)
        A(k,j).distance = sqrt((k-goal.i)^2 + (j-goal.j)^2); 
    end
end
Map = A;
end