function fitness = clustering_objective(centroids_vector, points, K, dim)
    centroids = reshape(centroids_vector, [K, dim]);
    D = pdist2(points, centroids, 'squaredeuclidean');
    [min_dist, ~] = min(D, [], 2);
    fitness = sum(min_dist);
end