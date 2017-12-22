function blob_detecter_1(img_path, sigma, num_of_scales, scale_factor, threshold)
    disp("Increasing the filter size: "+ img_path);
    %Load image
    im = imread(img_path);
    
    %Convert to greyscale
    img = rgb2gray(im);

    %Convert to double
    double_img = im2double(img);
    
    %Image size
    img_size = size(double_img);
    
    %Create scale space to hold the filter response
    scale_space = zeros(img_size(1), img_size(2),num_of_scales);
    
    tic
    %Apply scaled filters on the given image
    for i=1:num_of_scales
        scale_sigma = sigma * scale_factor^(i-1);
        LoG = createFilter(scale_sigma, 1);
        filter_response = extractFilterResponse(double_img , LoG);
        scale_space(:, :, i) = filter_response .^ 2;
    end
    toc
    
    %Scale space to save local maximum
    max_values = zeros(img_size(1), img_size(2), num_of_scales);
    for i=1:num_of_scales
        max_values(:, :, i) = ordfilt2(scale_space(:,:,i), 5^2, ones(5,5));
    end

    cols = [];
    rows = [];
    radiis = [];
    
    blobs = zeros(img_size(1), img_size(2), num_of_scales);
    %Perfor non maxima suppression after checking the threshold
    for i=1:img_size(1)
        for j=1:img_size(2)
             maxpixel = max(max_values(i,j,:));
             if maxpixel >= threshold
                blobs(i, j, :) = maxpixel;
             end
        end
    end
    blobs = blobs .* (blobs == scale_space);
    
    %Save pixel position for blob centre and the radii for visual
    for i=1:num_of_scales
        [row , col] = find(blobs(:,:,i));
        rows = [rows; row];
        cols = [cols; col];
        temp_radii = sigma * scale_factor.^(i-1) * sqrt(2); 
        radii = repmat(temp_radii, [size(row,1), 1]);
        radiis = [radiis; radii];
    end

    show_all_circles(im, cols, rows, radiis, 'r', 1)

end


