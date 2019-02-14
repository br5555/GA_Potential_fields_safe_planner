clc
clear all
close all
figure();
h = zeros(1,5);
h(1)= plot([0 1 2 3 4 5 6 7 8 9 10 11 12 13] ,[0 1 1 2 2 3 4 5 5 4 5 6 7 7], 'LineWidth', 3, 'Color','r','DisplayName','Roditelj 1'); 
hold on;
h(2) = plot([0 0 0 1 2 3 3 4 5 6 7 8 8 9 10 11 12 13 13] ,[0 1 2 3 3 4 4 4 5 6 6 6 7 7 8 9 8 8 7], 'LineWidth', 3,'Color','b','DisplayName','Roditelj 2');
h(3) = plot([3 3 3], [2 3 4], '--', 'LineWidth', 3,'DisplayName','Crossover point')
grid on
xlim([0 15])
ylim([0 10])
h(4) = plot(0,0, 'r*','LineWidth', 8)
text(0.6,0.3,'Start')
h(5) = plot(13,7,'g*', 'LineWidth', 8)
text(13.6,7.3,'Cilj')
grid minor
set(gca,'xtick',[0:5:15])
set(gca,'ytick',[0:5:10])
legend(h(1:3));

figure();
h = zeros(1,5);
h(1)= plot([0 1 2 3 3 4 5 6 7 8 8 9 10 11 12 13 13] ,[0 1 1 2 3 4  5 6 6 6 7 7 8 9 8 8 7], 'LineWidth', 3,'DisplayName','Dijete 1'); 
hold on;       
h(2)= plot([0 0 0 1 2 3 3 4 4 5 6 7 8 9 10 11 12 13 ] ,[0 1 2 3 3 4 4 3 2 3 4 5 5 4 5 6 7 7], 'LineWidth', 3,'DisplayName','Dijete 2'); 
h(3)= plot([3 3 3], [2 3 4], '--', 'LineWidth', 3, 'DisplayName','Crossover point')
grid on
xlim([0 15])
ylim([0 10])
h(4)= plot(0,0, 'r*','LineWidth', 8)
text(0.6,0.3,'Start')
h(5)= plot(13,7,'g*', 'LineWidth', 8)
text(13.6,7.3,'Cilj')

grid minor
set(gca,'xtick',[0:5:15])
set(gca,'ytick',[0:5:10])
legend(h(1:3));


figure();
h = zeros(1,5)
h(1)= plot([0 1 2 3 4 5 6 7 8 9 10 11 12 13] ,[0 1 1 2 2 3 4 5 5 4 5 6 7 7], 'LineWidth', 5, 'Color','m','DisplayName','Dijete'); 
hold on;
h(2)= plot([0 1 2 3 4 5 6 7 8 9 10 11 12 13] ,[0 1 1 2 2 3 4 5 6 7 7 7 7 7], 'LineWidth', 3, 'Color','c','DisplayName','Mutirano Dijete'); 
grid on
xlim([0 15])
ylim([0 10])
h(4)= plot(0,0, 'r*','LineWidth', 10)
text(0.6,0.3,'Start')
h(5) = plot(13,7,'g*', 'LineWidth', 10)
text(13.6,7.3,'Cilj')
h(3) = plot(7,5,'k*', 'LineWidth', 10)
text(7,5.5,'Tocka mutacije')
grid minor
set(gca,'xtick',[0:5:15])
set(gca,'ytick',[0:5:10])
legend(h(1:2));
