figure();
x_s = [];
y_s = [];

for i = 1: length(path)
    x_s = [x_s, path(i).i];
    y_s = [y_s, path(i).j];
end

plot(x_s, y_s, 'LineWidth', 5)

hold on
x_s = [];
y_s = [];
for i = 1: length(path1)
    x_s = [x_s, path1(i).i];
    y_s = [y_s, path1(i).j];
end
plot(x_s, y_s, 'LineWidth', 5)
x_s = [];
y_s = [];
for i = 1: length(child_1)
    x_s = [x_s, child_1(i).i];
    y_s = [y_s, child_1(i).j];
end
plot(x_s, y_s, 'LineWidth', 3)
x_s = [];
y_s = [];
for i = 1: length(child_2)
    x_s = [x_s, child_2(i).i];
    y_s = [y_s, child_2(i).j];
end
plot(x_s, y_s, 'LineWidth', 3)
