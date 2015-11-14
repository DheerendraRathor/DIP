%% Loading the Yale Dataset
training_size_per_user = 45;
test_size_per_user = 15;

tic;
    [X, Y, C] = getYaleImages(training_size_per_user, test_size_per_user);
toc;

% Variables
ks = [1, 10, 50, 100, 500];
R_fisher = ones(1, size(ks, 2));
R_eigen_1 = zeros(1, size(ks, 2));
R_eigen_4 = zeros(1, size(ks, 2));

%% Running the FisherFace PCA algorithm
tic;
    W_fisher = getFisherFacePM(X, training_size_per_user*C, C, training_size_per_user);   
    R = runProjectionMatrix(X, Y, W_fisher, training_size_per_user, test_size_per_user);
    R_fisher = R * R_fisher;
toc;

%% Running the EigenFace PCA algorithm with first 3 removed
tic;
    for i = 1:size(ks, 2)
        k = ks(1, i);
        W_eigen_4 = getEigenFacePM(X, 4, k);
        R_eigen_4(1, i) = runProjectionMatrix(X, Y, W_eigen_4, ...
            training_size_per_user, test_size_per_user);
    end
toc;

%% Running the EigenFace PCA algorithm
tic;
    for i = 1:size(ks, 2)
        k = ks(1, i);
        W_eigen_1 = getEigenFacePM(X, 1, k);
        R_eigen_1(1, i) = runProjectionMatrix(X, Y, W_eigen_1, ...
            training_size_per_user, test_size_per_user);
    end;
toc;


%% Error Plot
R_fisher = (1 - R_fisher)*100.0;
R_eigen_1 = (1 - R_eigen_1)*100.0;
R_eigen_4 = (1 - R_eigen_4)*100.0;

plot(ks, R_fisher, '--ko', ks, R_eigen_1, '-db', ks, R_eigen_4, '-sm');
