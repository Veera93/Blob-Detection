function [LoG] = createFilter(sigma, isNorm)
    filt_size =  2*ceil(3*sigma)+1;
    %Scale normalization in case of varying filter size
    if isNorm
        LoG = (sigma ^ 2) * fspecial('log', filt_size, sigma);
    else
    %Scale normalization is not needed when the filter size is constant
        LoG = fspecial('log', filt_size, sigma);
    end
end