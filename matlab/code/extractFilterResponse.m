function [filterResponse] = extractFilterResponse(img, LoG)
%Using replicate filter method 
%to avoid false blob detection at the outer pixels
    filterResponse = imfilter(img, LoG, 'replicate');