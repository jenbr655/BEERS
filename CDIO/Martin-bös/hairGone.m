close all

im = imread('Snap_004.jpg');
im = rgb2gray(im);
im = imresize(im, 0.5);

binvect = 0:1:255;
histo = hist(im(:), binvect);

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
lpH=lpH/sum(lpH); % Horizontal filter 
lpV=lpH'; % Vertical filter
gauss = conv2(lpV,lpH,'full');

aver3im =0*im; %Array of zeros
%center = size(im,1)/2+1;
[row,col] = size(im)

centerx = row/2;
centery = col/2;

aver3im(centerx-3:centerx+3, centery-3:centery+3) = gauss; %Centering Gaussian filter in the image before transform 

%%
GAUSS = fftshift(fft2(ifftshift(aver3im)));
IM = fftshift(fft2(ifftshift(im)));
IMCIRCCONV = IM.*GAUSS;
imcircconv = fftshift(ifft2(ifftshift(IMCIRCCONV)));

se2 = strel('disk',2);
hairs = imtophat(imcircconv,se2);

figure
imagesc(imcircconv)

%%

T = graythresh(hairs);
hairsbin = imbinarize(hairs,T);
se4 = strel('disk',4);
hairsbin = imclose(hairsbin, se4);
hairsbin = imclose(hairsbin, se4);

imagesc(hairsbin), colorbar

im_gauss(hairsbin > 0) = mean(mean(im_gauss));
im(hairsbin > 0) = mean(mean(im_gauss));
% 
% figure
% subplot(121),imagesc(im_gauss),colorbar
% subplot(122), imagesc(im)

%%
% figure
% imagesc(im)

idx = find(hairsbin > 0);
interpol = interp(im,idx);  %Hittar idx i originalbilden och sätter till medelvärde av omkringliggande pixlar
%interpol = interp2(im,idx);

figure
imagesc(interpol)

%%
T = graythresh(interpol);
imbin = imbinarize(interpol,T);
imbin = ~imbin;

se = strel('square',4);
imC = imclose(imbin, se);
imO = imopen(imC,se);
BW = bwareaopen(imO,1000);
BWfill = imfill(BW,'holes');

figure
subplot(221),imshow(imC)
subplot(222),imshow(imO)
subplot(223),imshow(BW)
subplot(224),imshow(BWfill)


