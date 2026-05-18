% ABC source code
% https://www.mathworks.com/matlabcentral/fileexchange/74122-artificial-bee-colony-optimization

function [bestsol,bestfitness] = ABC(prob,lb,ub,Np,T,limit)

%% Starting of ABC
f = NaN(Np,1);                      % Vector to store the objective function value of the population members
fit = NaN(Np,1);                    % Vector to store the fitness function value of the population members
trial = NaN(Np,1);                  % Initialization of the trial vector

D = length(lb);                     % Determining the number of decision variables in the problem

P = repmat(lb,Np,1) + repmat((ub-lb),Np,1).*rand(Np,D);   % Generation of the initial population

for p = 1:Np
    f(p) = prob(P(p,:));            % Evaluating the objective function value
    fit(p) = CalFit(f(p));          % Evaluating the fitness function value
end

[bestobj, ind] = min(f);            % Determine and memorize the best objective value
bestsol = P(ind,:);                 % Determine and memorize the best solution

% === Display initialization ===
fcount = Np;
stall = 0;
prev_best = bestobj;
fprintf('\n%-10s %-10s %-15s %-15s %-10s\n', 'Iteration', 'f-count', 'Best f(x)', 'Mean f(x)', 'Stall');
fprintf('%s\n', repmat('-', 1, 65));

for t = 1:T

    %% Employed Bee Phase
    for i = 1:Np
        [trial,P,fit,f] = GenNewSol(prob, lb, ub, Np, i, P, fit, trial, f, D);
    end

    %% Onlooker Bee Phase
    % as per the code of the inventors available at https://abc.erciyes.edu.tr/
    % prob=(0.9.*Fitness./max(Fitness))+0.1;

    probability = 0.9 * (fit/max(fit)) + 0.1;

    m = 0; n = 1;

    while(m < Np)
        if(rand < probability(n))
            [trial,P,fit,f] = GenNewSol(prob, lb, ub, Np, n, P, fit, trial, f, D);
            m = m + 1;
        end
        n = mod(n,Np) + 1;
    end

    [bestobj,ind] = min([f;bestobj]);
    CombinedSol = [P;bestsol];
    bestsol = CombinedSol(ind,:);

    %% Scout Bee Phase
    [val,ind] = max(trial);

    if (val > limit)
        trial(ind) = 0;                     % Reset the trial value to zero
        P(ind,:) = lb + (ub-lb).*rand(1,D); % Generate a random solution
        f(ind) = prob(P(ind,:));            % Determine the objective function value of the newly generated solution
        fit(ind) = CalFit(f(ind));          % Determine the fitness function value of the newly generated solution
    end

    % === Stall detection & display ===
    if bestobj < prev_best
        stall = 0;
        prev_best = bestobj;
    else
        stall = stall + 1;
    end
    current_mean = mean(f);
    fprintf('%-10d %-10d %-15.4f %-15.4f %-10d\n', t, fcount, bestobj, current_mean, stall);

end

fprintf('%s\n', repmat('-', 1, 65));
[bestfitness,ind] = min([f;bestobj]);
CombinedSol = [P;bestsol];
bestsol = CombinedSol(ind,:);
fprintf('Final Best: %.4f | Total f-count: %d | Final Stall: %d\n', bestfitness, fcount, stall);


%% Bee colony functions
function fit = CalFit(f)

if f >= 0
    fit  = 1 / (1+f);
else
    fit = 1 + abs(f);
end

function [trial,P,fit,f] = GenNewSol(prob, lb, ub, Np, n, P, fit, trial, f, D)

j = randi(D,1);                 % Randomly select the variable that is to be changed
p = randi(Np,1);                % Randomly select the neighbour

while (p == n)                  % Ensuring that the neighbour is different from the current solution
    p = randi(Np,1);
end

Xnew = P(n,:);                  % Variable to generate a new solution

Phi = -1 + (1-(-1))*rand;       % Generating a random number between -1 and 1

Xnew(j) = P(n,j) + Phi*(P(n,j) - P(p,j));  % Generating a new solution
Xnew(j) = min(Xnew(j),ub(j));    % Bounding the violating variables to their upper bound
Xnew(j) = max(Xnew(j),lb(j));    % Bounding the violating variables to their lower bound

ObjNewSol = prob(Xnew);             % Determining the objective function value
FitnessNewSol = CalFit(ObjNewSol);  % Determining the fitness function value

if (FitnessNewSol > fit(n))
    P(n,:) = Xnew;               % New solution enters the pool of solutions
    fit(n) = FitnessNewSol;      % Update the fitness value
    f(n) = ObjNewSol;            % Update the objective function value
    trial(n) = 0;                % Resetting trial to zero
else
    trial(n) = trial(n)+1;       % Increase the value of the trial counter
end