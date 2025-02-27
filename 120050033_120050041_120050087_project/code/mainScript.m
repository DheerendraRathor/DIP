%% Eigenfaces vs. Fisherfaces: Recognition Using Class Specific Linear Projection
% 
% *Paper Authors*: Peter N. Belhumeur, Joao~ P. Hespanha, and David J. Kriegman
%
% *Project by:*
%
% * Bijoy Singh Kochar (120050087)
% * Dheerendra Singh Rathor (120050033)
% * Nishant Koushik (120050041)
%
% *Key Points*
%
% * Higher dimensionality to lower dimensionality reduction
% * Projection direction orthogonal to within class scatter
% * Projects away variations in lighting and facial expression
% * PCA - Just maximizes the total scatter
% * Calculates between class scatter and within class scatter
% * Tries to maximize the ratio of determinents
% * Uses generalized eigenvectors
% 
% *Algorithm:*
% 
% * Get $$ W_{pca} $$ as PCA with N-c principle components
% * Calculates $$ S_b $$ using $$ N_i(u_i - u)(u_i - u)^T $$
% * Calculates $$ S_w $$ by $$ (x_k-u_i)(x_k-u_i)^T $$
% * Get $$ W_{fld} $$ as c-1 generalized eigenvector between $$ S_b $$ and $$
% S_w $$
% * Return $$ W_{pca} * W_{fld} $$
%
% *Key Observations:*
%
% * Better performance than both eigenfaces with and without removing first
% three principle components
% * Noticed that basic implementations of PCA suffer from issue with
% singular and close to singular matrices. Hence we opted to use built-in
% pca
% * The $$ S_{w} $$ and $$ S_{b} $$ generalized eigenvectors leads to a low
% conditional number matrix because $$ S_w $$ is close to singular
% * The naive implementation of the algorithm will lead to a huge memory
% overhead of $$ d^2 $$. Hence a projected version of dataset is used to
% compute the values of $$ S_b $$ and $$ S_w $$ like the paper recommends
% to compute $$ {W_{pca}}^TS_bW_{pca} $$ to improve performances of closed to singular
% matrices
% * Also observed that the eigenfaces with three removed principle
% components performed significantly better than without removal
%
% 
%% Execution
[R_fisher, R_eigen_1, R_eigen_4, ks] = runYaleData();

figure('Name','Eigenfaces vs Fisherfaces','NumberTitle','off')
plot(ks, R_fisher, '--ko', ks, R_eigen_1, '-db', ks, R_eigen_4, '-sm');
title('Comparison of errors amongst eigenfaces and fischerfaces algorithm');
legend('Fisherface', 'Eigenfaces', 'Eigenfaces with first 3 removed');
xlabel('k (for eigenfaces)');
ylabel('% errors');

%% Key Features
% * We implemented a caching policy which reduces running time from
% approximately 5.5 minutes to ~11 seconds by storing precomputed results
% and datasets
% * Handled pca to prevent low condition number and related singularity issues.
%
% _May the Cache be With You!_