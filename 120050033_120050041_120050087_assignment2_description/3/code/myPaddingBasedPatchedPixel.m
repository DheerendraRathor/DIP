function pixel = myPaddingBasedPatchedPixel(image, point, window, sigma, memoised)
    [rmin, rmax, cmin, cmax] = myGetWindowBoundaries(image, point, [window, window]);
    
    diff_matrix = bsxfun(@minus, memoised(rmin:rmax,cmin:cmax,:,:), memoised(point(1,1), point(1,2),:,:));
    
    [row, col, px, py] = size(diff_matrix);
    weights = zeros(row, col);
    
    for i = 1:row
        for j = 1:col
            tmatrix = squeeze(diff_matrix(i,j,:,:));
            euclidian_dist = norm(tmatrix);
            weights(i,j) = exp(-euclidian_dist/(sigma.^2));
        end
    end
    
    intensity = image(rmin:rmax, cmin:cmax).*weights;
    pixel = sum(sum(intensity))/sum(sum(weights));
end