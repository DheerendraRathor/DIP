function myShowImagesRGB(images, image_title)
    count = size(images, 4);
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    for i = 1:count
        sub = subplot(1, count, i);
        imagesc(uint8(images(:,:,:,i)));
        daspect([1 1 1]);
        axis tight;
        original_size = get(sub, 'Position');
    end
    colorbar;
    set(sub, 'position', original_size);
    suptitle(image_title);
end