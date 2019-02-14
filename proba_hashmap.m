clc
clear all
close all

ids = [1 2 3];
ids2 = [1000 2888 2888];
names = {'Lee, N.','Jones, R.','Sanchez, C.'};
M = containers.Map(ids,names)
M2 = containers.Map(ids2,ids)

%sort ascending
sort(cell2mat(M.keys))
M2.values
%%
clc
clear all
close all
ids2 = [2888 1000  2888];
names = {'Lee, N.','Jones, R.','Sanchez, C.'};

paths = {};
for ajmo = 1:3
    path = [];
for o = 1+(ajmo-1)*3:3+(ajmo-1)*3
        s.i = 1;
        s.j = o;
        s.appealing = -1;
        s.repellent = -1;
        s.obstacle = false;
        s.distance = 0;
        A(1,o) = s;
        path = [path, A(1,o) ];
end
ajmo
path
    paths{ajmo} = path;
end

[a_sorted, a_order] = sort(ids2);
newB = paths(a_order);