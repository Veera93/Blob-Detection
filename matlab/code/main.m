clear;
imName = {'butterfly.jpg','fishes.jpg','einstein.jpg','sunflowers.jpg', 'texture.jpg', 'choco.jpg', 'flamingo.jpg', 'cheet.jpg'};
test_name = {'blobs_butterfly.gif','blobs_fishes.gif','blobs_einstein.gif','blobs_sunflowers.gif'};

threshold = 0.005;
n = 5;
sigma = 2.5;
k = 2;

%Comparision
for i=1:size(imName, 2)
    im_path = strcat('../data/',imName{i});
    index = (i-1) * size(imName, 2);
    figure(i);
    subplot(2,2,1);
    imshow(im_path);
    title("Original Image");
    
    %Check if sample output of the image is given, if so display them too
    if i <= size(test_name, 2)
        test_path = strcat('../data/',test_name{i});
        subplot(2,2,2);
        imshow(test_path);
        title("Sample Blob");
    end
    
    subplot(2,2,3);
    blob_detecter_1(im_path, sigma, n, k, threshold);
    title("Increasing the filter size");
    
    subplot(2,2,4);
    blob_detecter_2(im_path, sigma, n, k, threshold);
    title("Downscaling the Image");
end

%Display
%{
for i=1:size(imName, 2)
    im_path = strcat('../data/',imName{i});
    index = (i-1) * size(imName, 2);
    figure(i);
    blob_detecter_1(im_path, sigma, n, k, threshold);
    blob_detecter_2(im_path, sigma, n, k, threshold);
    disp("----------------------------")
end
%}