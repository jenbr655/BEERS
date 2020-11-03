close all
im = imread('amandasunderarm.jpg');
im = rgb2gray(im);
im = imresize(im, 0.5);
im = double(im);
im = im/max(max(im)); %Graythresh assumes value/takes values between [0 1]

%% Transform commands
%fftshift: Shift zero-frequency component to center of spectrum.
%     For vectors, fftshift(X) swaps the left and right halves of
%     X.  For matrices, fftshift(X) swaps the first and third
%     quadrants and the second and fourth quadrants.  For N-D
%     arrays, fftshift(X) swaps "half-spaces" of X along each
%     dimension.

%fft2: fft2(X) returns the two-dimensional Fourier transform of matrix X.
%     If X is a vector, the result will have the same orientation.

%ifftshift: For vectors, ifftshift(X) swaps the left and right halves of
%     X.  For matrices, ifftshift(X) swaps the first and third
%     quadrants and the second and fourth quadrants.  For N-D
%     arrays, ifftshift(X) swaps "half-spaces" of X along each
%     dimension.

%F = fftshift(fft2(ifftshift(f)));
%f = fftshift(ifft2(ifftshift(F)));

%% Circular convolution

sigma = 2;
lpH=exp(-0.5*([-3:3]/sigma).^2); 
lpH=lpH/sum(lpH); %Horizontal filter 
lpV=lpH'; %Vertical filter
gauss = conv2(lpV,lpH,'full'); %Gaussian filter

gausskern =0*im; %Array of zeros
%center = size(im,1)/2+1;
[row,col] = size(im);

centerx = row/2; %Center row
centery = col/2; %Center column

gausskern(centerx-3:centerx+3, centery-3:centery+3) = gauss; %Centering Gaussian filter in the image before transform 
IM = fftshift(fft2(ifftshift(im))); %Fourier transform of im
GAUSSKERN = fftshift(fft2(ifftshift(gausskern))); %Fourier transorm of averageing kernel
AVERIM = IM.*GAUSSKERN; %Filtering in the fourier domain => averaged image
averim = real(fftshift(ifft2(ifftshift(AVERIM)))); %Filtered image

% figure
% subplot(121),imagesc(im), colorbar
% subplot(122),imagesc(averim), colorbar

%% Vascular detection





