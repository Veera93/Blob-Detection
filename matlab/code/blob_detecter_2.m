function blob_detecter_2(img_path, sigma, num_of_scales, scale_factor, threshold)
    disp("Downscaling the Image: "+ img_path);
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
    %Filter 
    LoG = createFilter(sigma, 1);
    temp_img = double_img;
    for i=1:num_of_scales
        factor = scale_factor^(i-1);
        temp_img = imresize(double_img, 1/factor, 'bicubic');
        filerResponse = extractFilterResponse(temp_img , LoG);
        filerResponse = filerResponse .^ 2;
        scale_space(:, :, i) = imresize(filerResponse, size(double_img), 'bicubic');
        
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
        radii = repmat(temp_radii, [size(row, 1), 1]);
        radiis = [radiis; radii];
    end

    show_all_circles(im, cols, rows, radiis, 'r', 1)

end