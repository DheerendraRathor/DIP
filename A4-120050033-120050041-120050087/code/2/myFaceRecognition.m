function X = myFaceRecognition(X, Y, k, dpu, tpu)
    %% Function Doc
    % X - training dataset
    % Y - testing set
    % k - number of eigen values
    % dpu - training data images per user
    % tpu - testign data images per user

    %% Training Phase
    
    % Using the faster mode of PCA, computing the C
    C = X' * X;
    
    % Computing the k max eigen values, vector of the covariance matrix
    [Evec, Eval] = eigs(C, k);
    
    % Computing the new datset
    V = X * Evec;
    
    % Normalizing the new dataset
    Vn = normc(V);
    
    
    %% Testing Phase
    
    % Number of test images
    num_test_images = size(Y, 2);
   
    % Project to reduced eigen space of dataset and normalise
    Yn = normc(Y * Evec);
    
    % Find the closest dataset point for each point in the testset
    closest_indices = dsearchn(Vn', Yn');
    
    % Iteratign over  the closest indices to find recognition rate
    correct_count = 0;
    for i =  1:num_test_images
        predicted_user = getUserId(closest_indices(i, 1), dpu);
        actual_user = getUserId(i, tpu);
        if eq(predicted_user, actual_user)
            correct_count = correct_count + 1;
        end
    end
    
    % Recognition Rate
    display(correct_count / num_test_images);
end

function user = getUserId(index, ipu)
% Finds the user index given the image index and the images per user
    user = idivide(int32(index-1), int32(ipu), 'floor') + 1;
end