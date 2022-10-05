%% Load a file
load('randomwalk.mat');

%% Figure

fig1 = figure(1);

%% Plot a trajectory

plot(X(14,:)) %%the plot function reads the X data of row 1 of randomwalk.mat and plots it 
%%plot(X(100,:))

%% Plot 4 trajectories

ax = [];

ax(1) = subplot(222); %%subplot(abc) where a = # r, b = #c, c = which one
plot(X(1,:));
ax(2) = subplot(221);
plot(X(2,:));
ax(3) = subplot(223);
plot(X(3,:));
ax(4) = subplot(224);
plot(X(4,:));

%% Plot limits

xlim([0 1000])

%% Make labels

xlabel(ax(1), 'timesteps');
ylabel(ax(1), 'position');

%% Make a loop

for number = 1:4
    xlim(ax(number),[0,1000])
    ylim(ax(number),[-40,40])
    xlabel(ax(number),'timestep')
end

%% Plot multiple traces

fig2 = figure(2);

%%plot(X(1:5,:));

for i = 1:501
    plot(X(i,:))
    hold on
    
end

hold off
legend









