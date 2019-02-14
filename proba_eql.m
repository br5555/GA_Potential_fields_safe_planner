clc
clear all
for o = 1:3
        s.i = 1;
        s.j = o;
        s.appealing = -1;
        s.repellent = -1;
        s.obstacle = false;
        s.distance = 0;
        A(1,o) = s;
end

if(isequaln(A(1,1), A(1,1)))
   1
else
    0
end