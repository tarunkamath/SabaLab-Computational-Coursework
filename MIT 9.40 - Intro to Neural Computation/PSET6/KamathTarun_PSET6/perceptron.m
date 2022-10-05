%% Program to demonstrate perceptron learning rule
%
rng(50);                 % Seed random number generator for reproducibility
m1=1000;                 % number of samples in set 1
m2=m1;                	 % number of samples in set 2
m=m1+m2;				 % total number of samples
%
a=4;					 % Cluster 1 centered at position (4,4) 
b=0;					 % Cluster 2 centered at position (0,0) 
c1=repmat([a ; a], 1, m1);    % center of cluster 1 (4,4)
c2=repmat([b ; b], 1, m2);    % center of cluster 2 (0,0)
%
x1=c1+randn(2, m1);      % set 1 is a Gaussian cluster centered at c1
x2=c2+randn(2, m2);      % set 2 is a Gaussian cluster centered at c2

T1=ones(1, m1) ;         % Classes coded as 1 and 0
T2=zeros(1,m2);

T=cat(2,T1,T2);% Class labels
x=cat(2,x1,x2); % data points
%

fg =figure(1);
plot(x1(1,:), x1(2,:), 'ob')
hold on
plot(x2(1,:), x2(2,:), 'or')
ax = gca;
ax.XAxisLocation='origin';
ax.YAxisLocation='origin';
ax.LineWidth=2;
ax.FontSize=14;
box off
fg.Color='w';


j=randperm(m);% Random permutation of the data points
T=T(j);
x=x(:,j);

theta=1;% Threshold
eta=0.05;% learning rate
%
w=[.75;-.5];                % initial guess for weight vector



% Main for loop
% Visit the data points in random sequence to learn the weights
for i=1:m
   
    %%% follow instructions to complete for loop %%%
      
    % project the ith data point onto w and compute the output of the
    % perceptron
    ithvector = x(1:2,i);
    projection = dot(ithvector,w);
    output = projection-theta;
    binaryoutput = 0;
    if output > 0
        binaryoutput = 1;
    end
    % compute the update (delta w) to the weight vector under these two
    % conditions:
    deltaw = [0;0];
    % if the classification was correct:
    if binaryoutput == T(1,i)
        deltaw = [0;0];
    else
        % if the classification was incorrect:

        if T(1,i) == 1
            deltaw = eta*ithvector;
        else
            deltaw = -eta*ithvector;
        end
    end
    
    
    % update the weight vector 
 w = w+deltaw;
  
         
end

%%% Your code to add  the decision boundary to figure (1) goes here%%%
firstcoord = 1/w(1);
secondcoord = 1/w(2);

plot([0 firstcoord], [secondcoord 0]);

hold off


