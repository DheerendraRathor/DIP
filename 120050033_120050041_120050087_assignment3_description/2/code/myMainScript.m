%% MyMainScript

tic;
%% Your code here
addpath('../../common/');

load ../data/boat.mat;
gpu_image = imageOrig;

% harris_image = myHarrisCornerDetector(gpu_image, 20, [9, 9], 0.24);
harris_image = myHarrisCornerDetector(gpu_image, 0.5, [21, 21], 0.005);

toc;
