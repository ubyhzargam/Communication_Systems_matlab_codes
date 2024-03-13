%%Rolling of a die
N=input("Enter the number of die to be rolled");
num_trials=input("Enter the number of times you want the die to be rolled");
central_limit_theorem(N,num_trials);

%% Tossing a coin 
N=input("Enter the number of coins");
num_trials=input("Enter the number of trials of coin tosses ");
central_limit_theorem1(N,num_trials);

function central_limit_theorem(N,num_trials)
    rolls=zeros(num_trials,N);
    for i=1:num_trials
        rolls(i,:)=randi([1,6],1,N);
    end
    sums=sum(rolls,2);
    figure;
    histogram(sums, 'Normalization', 'probability', 'BinWidth', 1, 'EdgeColor','w');
    title(sprintf("Central Limit Theorem for rolling %d fair dice %d times",N,num_trials));
    xlabel("Sum of Dice rolls");
    ylabel("Probability");
end

function central_limit_theorem1(N,num_trials)
tosses=randi([0,1],num_trials,N);
sums=sum(tosses,2);
figure;
histogram(sums,'Normalization','probability','BinWidth',1,'EdgeColor','w');
title(sprintf("Central Limit Theorem for rolling %d fair dice %d times",N,num_trials));
    xlabel("Sum of Dice rolls");
    ylabel("Probability");
end

