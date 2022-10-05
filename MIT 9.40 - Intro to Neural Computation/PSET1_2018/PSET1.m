    %% Load a file
load('randomwalk.mat');

%% Plot trajectory of particle #14 (1-3)

fig1 = figure(1);
plot(X(14,:)) 

%% Plot all trajectories (1-4)

fig2 = figure(2);

for i = 1:500
    plot(X(i,:))
%     hold on
    
end

hold off

%% Plot mean displacement over time (1-5)

fig3 = figure(3);
meandisplacement = [];

M = mean(X);
plot([1:1001],M)

%% Plot mean square displacement over time (1-6)

fig4 = figure(4);
squaredisplacement = X.^2;

meansquaredisplacement = mean(squaredisplacement);
plot([1:1001],meansquaredisplacement)

%% 

        

