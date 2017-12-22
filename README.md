# Blob Detection

#### INTRODUCTION:

The goal of the assignment is to implement a scale invariant blob detector using Laplacian of Gaussian. The algorithm is as follows,

1.	Generate Laplacian of Gaussian filter.
2.	Build a Laplacian scale space, starting with some initial scale and going for n iterations:
a.	Filter image with scale-normalized Laplacian at current scale. 
b.	Save square of Laplacian response for current level of scale space.
c.	Increase scale by a scale factor.
3.	Perform non-maximum suppression in scale space.
4.	Display resulting circles at their characteristic scales.

In this algorithm, scaling can be achieved either by increasing the filter size of the LoG filter and convoluting it with the image of constant size or by downscaling the image and convoluting it with the constant filter size. The report compares both these implementations and finds the time efficient implementation.

#### IMPLEMENTATION:

1.	Load the image and convert it to greyscale using rgb2gray function and then to double using im2double function.
2.	Create a scale space of n dimension to the save the filter response of n different scales.
3.	To create the scale-space we could use any two of the below approach
a.	Create Laplacian of Gaussian with scaled filter size using fspecial and use imfilter to get the filter response of the given image. Finally square the response and save it in scale space.
b.	Create Laplacian of Gaussian with fixed filter size using fspecial and use imfilter to get the filter response of the scaled image. Finally square the response and save it in scale space. Note: This method is an efficient method as creating various filters of increasing size is computation heavy.
4.	For performing non-maxima suppression, first apply ordfilt2 to replace local region by highest order in the region.
5.	After that, find the maximum intensity of a pixel in the n scale space and replaced all scale space with the same value.
6.	Now perform the non-maxima suppression
7.	Use the find function to save the pixel position and radius (radius = stigma *  sqrt(2)) and use them to visual represent blobs.
