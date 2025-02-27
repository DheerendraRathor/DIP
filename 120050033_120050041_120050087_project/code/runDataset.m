function [R_fisher, R_eigen_1, R_eigen_4] = runDataset(X, Y, C, training_size_per_user, test_size_per_user, folder, ks)
    % Variables
    R_fisher = ones(1, size(ks, 2));
    R_eigen_1 = zeros(1, size(ks, 2));
    R_eigen_4 = zeros(1, size(ks, 2));

    %% Running the FisherFace PCA algorithm
    tic;
        W_fisher = getFisherFacePM(X, training_size_per_user*C, C, training_size_per_user, folder);   
        R = runProjectionMatrix(X, Y, W_fisher, training_size_per_user, test_size_per_user);
        R_fisher = R * R_fisher;
    elapsed_time = toc;
    fprintf('Elapsed time for Fischerfaces algorithm is %.6f seconds\n',...
        elapsed_time);

    %% Running the EigenFace PCA algorithm with first 3 removed
    tic;
        for i = 1:size(ks, 2)
            k = ks(1, i);
            W_eigen_4 = getEigenFacePM(X, 4, k, folder);
            R_eigen_4(1, i) = runProjectionMatrix(X, Y, W_eigen_4, ...
                training_size_per_user, test_size_per_user);
        end
    elapsed_time = toc;
    fprintf(strcat('Elapsed time for Eigenface PCA Algorithm ',...
        'is %.6f seconds\n'), elapsed_time);

    %% Running the EigenFace PCA algorithm
    tic;
        for i = 1:size(ks, 2)
            k = ks(1, i);
            W_eigen_1 = getEigenFacePM(X, 1, k, folder);
            R_eigen_1(1, i) = runProjectionMatrix(X, Y, W_eigen_1, ...
                training_size_per_user, test_size_per_user);
        end;
    elapsed_time = toc;
    fprintf(strcat('Elapsed time for Eigenface PCA Algorithm without ', ...
        'first 3 components is %.6f seconds\n'), elapsed_time);


    %% Error Plot
    R_fisher = (1 - R_fisher)*100.0;
    R_eigen_1 = (1 - R_eigen_1)*100.0;
    R_eigen_4 = (1 - R_eigen_4)*100.0;

end