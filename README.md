# Bee Colony Optimisation Clustering MATLAB
The problem of clustering a set of data points $\mathfrak{X} = \{x_i \in \mathbb{R}^m : i = 1,2,\cdots,n\}$ is addressed by reformulating partitional clustering as a global optimisation problem [1]. Let $K$ be a natural number between 1 and $n$, the objective is to identify optimal cluster assignments for $\mathcal{C}=\{C_i\}^K, i=1,2,\cdots,K$ that satisfy following constraints [1,2]:

* $C_i \neq \emptyset, \quad i = 1, \dots, K$
* $C_i \cap C_j = \emptyset \quad \text{for all} \quad i,j = 1, \dots, K, \, i \neq j$
* $\mathfrak{X} = \bigcup_{i=1}^K C_i$

This repository contains a MATLAB implementation of search-based clustering by Bee Colony Optimisation [3] to optimise the following objective function [1,2]:

$$
J(\mathcal{C}) = \min \sum_{i=1}^K \sum_{x \in C_i} \Vert x-c_i \Vert^2 , \quad i=1,2,\cdots,K
$$

$$
\text{subject to} \quad c \in \mathbb{R}^m, \quad \sum_{x \in C_i} (x-c_i)=0
$$

The algorithm optimises intra-cluster distances to search for optimal cluster centroids.

## Files in this Repository
* **`ScriptABC.m`**: The main execution script. Adjust optimisation parameters based on specific requirement of clustering problem.
* **`clustering_objective.m`**: The objective function specifically written for partitional clustering. The function computes the squared Euclidean distance between data points and centroids, and returns total intra-cluster to minimise.
* **`ABC.m`**: Source code for Artificial Bee Colony (ABC) optimisation algorithm.
* **`Fowlkes_Mallows_index.m`**: An external cluster validity index introduced by [4] to evaluate cluster assignments between generated clusters and ground truth clusters.

## References
[1] A. Bagirov, N. Karmitsa, and S. Taheri, Partitional clustering via nonsmooth optimization: Clustering via optimization, 2nd ed. Cham, Switzerland: Springer International Publishing, 2024.

[2]	R. Scitovski, K. Sabo, F. Martínez-Álvarez, and Š. Ungar, Cluster analysis and applications, 2021st ed. Cham, Switzerland: Springer Nature, 2021.

[3] D. Karaboga, "An idea based on honey bee swarm for numerical optimization," Erciyes University, Engineering Faculty, Computer Engineering Department, Kayseri, Turkey, Tech. Rep. TR06, 2005.

[4] E. B. Fowlkes and C. L. Mallows, "A method for comparing two hierarchical clusterings," *Journal of the American Statistical Association*, vol. 78, no. 383, pp. 553-569, Jun. 1983, doi: [10.1080/01621459.1983.10478008](https://doi.org/10.1080/01621459.1983.10478008).

## Acknowledgement
Artificial Bee Colony Optimization Code: MathWorks File Exchange. Available at: [https://www.mathworks.com/matlabcentral/fileexchange/74122-artificial-bee-colony-optimization](https://www.mathworks.com/matlabcentral/fileexchange/74122-artificial-bee-colony-optimization)