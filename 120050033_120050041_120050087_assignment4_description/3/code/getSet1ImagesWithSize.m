function [X, Sa, Sb] = getSet1ImagesWithSize(image_dir, person_start, person_end, image_start, image_end)
% image_dir - Image directory
% person_start: starting index of folder (from 1)
% person_end: Ending index of folder 
% image_start: Starting index of each image (from 1)
% image_end: Ending index of each image

    X = [];
    
    % Looping over the people
    for person = person_start:person_end
        % Creating the directory name
        tdir = strcat(image_dir, '/s', num2str(person),'/');
        
        % Looping over the image of that person
        for image_id = image_start:image_end
            % Creating the name of the file
            image_filename = strcat(tdir, num2str(image_id),'.pgm');
            
            % Reading the file
            image = imread(image_filename);
            
            % Converting image to column
            image_col = reshape(image, [], 1);
               
            % This will give a warning saying its slow, however the image
            % reading step is the rate limiting step and even using the
            % standard way doesnt speed up anything. So, using this as this
            % is cleaner and easier to understand
            X = [X image_col];
        end
    end
    
    [Sa, Sb] = size(image);
    
    % Converting image from  uint to double for later calculations
    X = double(X); 
end