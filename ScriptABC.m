clc; clear; close all;
rng(42);

load asymmetric.mat;
points = zscore(points);
[n, m] = size(points);
K = 5;

% Bee colony search space
nvars = K * m;
lb = repmat(min(points), 1, K);
ub = repmat(max(points), 1, K);

% Bee colony optimisation settings
BeeSize = min(100,10*nvars);        % Population size (MATLAB suggested value)
MaxIter = 200 * nvars;              % No. of iterations (MATLAB suggested value)
limit = (BeeSize / 2) * nvars;      % Parameter limit indicating maximum number of failures (Simple heuristic)

% Optimisation function
obj_func = @(x) clustering_objective(x, points, K, m);

% Bee Colony Optimisation
[best_centroids_vec, fval] = ABC(obj_func, lb, ub, BeeSize, MaxIter, limit);
best_centroids = reshape(best_centroids_vec, [K, m]);

D = pdist2(points, best_centroids, 'squaredeuclidean');
[~, idx] = min(D, [], 2);
fprintf('Objective Value: %.4f\n', fval);

FMI = Fowlkes_Mallows_index(labels, idx);
fprintf('FMI: %.4f\n', FMI);
tabulate(idx)

figure;
gscatter(points(:,1), points(:,2), idx);
hold on;
plot(best_centroids(:,1), best_centroids(:,2), 'kx', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Centroids');
legend('Location', 'bestoutside');
title('Optimal Cluster Assignments');
grid on;