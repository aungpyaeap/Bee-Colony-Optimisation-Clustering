# Bee Colony Optimisation Clustering MATLAB
Bee Colony Optimisation Clustering by minimising intra-cluster squared Euclidean distances.

We will consider the problem of clustering a set of data points $\mathfrak{X} = \{x_i \in \mathbb{R}^m : i = 1,2,\cdots,n\}$ by reformulating clustering as a global optimisation problem to identify the optimal cluster assignments satisfying $C_i \cap C_j =  \emptyset, i \neq j$.

This repository contains a MATLAB implementation of search-based clustering by Bee Colony Optimisation [1].

For a typical approach with a predefined $K$ value, the objective function is used as:
```math
\min \sum_{i=1}^K \sum_{x \in C_i} \|x-c_i\|^2 , \quad i=1,2,\cdots,K \qquad
\text{subject to} \quad c \in \mathbb{R}^m, \quad \sum_{x \in C_i} (x-c_i)=0
```
The algorithm optimises intra-cluster distances to search for optimal cluster centroids.

Artificial Bee Colony Optimization Codebase: MathWorks File Exchange. Available at: [https://www.mathworks.com/matlabcentral/fileexchange/74122-artificial-bee-colony-optimization](https://www.mathworks.com/matlabcentral/fileexchange/74122-artificial-bee-colony-optimization)

## References
[1] D. Karaboga, "An idea based on honey bee swarm for numerical optimization," Erciyes University, Engineering Faculty, Computer Engineering Department, Kayseri, Turkey, Tech. Rep. TR06, 2005.

[2] E. B. Fowlkes and C. L. Mallows, "A method for comparing two hierarchical clusterings," *Journal of the American Statistical Association*, vol. 78, no. 383, pp. 553-569, Jun. 1983, doi: [10.1080/01621459.1983.10477908](https://doi.org/10.1080/01621459.1983.10478008).