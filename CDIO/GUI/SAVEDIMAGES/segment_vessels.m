close all
I=imread('smallvessels.jpg');
gray_pic = rgb2gray(I);
J=adapthisteq(gray_pic, 'cliplimit', 0.08, 'Distribution','rayleigh');
J = double(J);
%J = J/max(max(J));

figure
imshowpair(J,gray_pic,'montage'), colorbar

histo = hist(J(:),0:1:255);
figure
plot(histo)
%% Circular convolution, average filtering
sigma = 2;
lpH=exp(-0.5*([-3:3]/sigma).^2); 
lpH=lpH/sum(lpH); %Horizontal filter 
lpV=lpH'; %Vertical filter
gauss = conv2(lpV,lpH,'full'); %Gaussian filter

gausskern =0*J; %Array of zeros
%center = size(im,1)/2+1;
[row,col] = size(J);

centerx = row/2; %Center row
centery = col/2; %Center column

gausskern(centerx-3:centerx+3, centery-3:centery+3) = gauss; %Centering Gaussian filter in the image before transform 
IM = fftshift(fft2(ifftshift(J))); %Fourier transform of im
GAUSSKERN = fftshift(fft2(ifftshift(gausskern))); %Fourier transform of averageing kernel
AVERIM = IM.*GAUSSKERN; %Filtering in the fourier domain => averaged image
for i = 1:7
    AVERIM = IM.*GAUSSKERN;
end
averim = real(fftshift(ifft2(ifftshift(AVERIM)))); %Filtered image

kernel = [1 2 1; 2 4 2; 1 2 1] / 16;
kernel = conv2(conv2(kernel,kernel,'full'),kernel, 'full');
kernelkern = 0*J;

kernelkern(centerx-3:centerx+3, centery-3:centery+3) = kernel;
KERNELKERN = fftshift(fft2(ifftshift(kernelkern))); %Fourier transform of kernel kernel 
KERNIM = IM.*KERNELKERN;
for i = 1:7
    KERNIM = IM.*KERNELKERN;
end
kernim =real(fftshift(ifft2(ifftshift(KERNIM))));
%%
J = averim;
J = kernim;

% kernel = [1 2 1; 2 4 2; 1 2 1] / 16;
% J = conv2(J, kernel, 'same');
% N = 5;
% for k=1:N
%     J = conv2(J, kernel, 'same');
% end

figure
imshowpair(J,gray_pic,'montage'), colorbar

histo = hist(J(:),0:1:255);
figure
plot(histo)

[T,T1,T2] = midway(J);
imbin = imbinarize(J,T1);

figure
imshowpair(imbin, gray_pic, 'montage')

%%
W = double(watershed(imbin));
Dmin = imregionalmin(J);
CC = bwconncomp(Dmin,8);
figure, imagesc(W);
colormap(colorcube(300)), colorbar;
title('Watershed transform of D')
%%
ImLabel = labelmatrix(CC);
figure, imagesc(ImLabel);
colormap(colorcube(300)), colorbar;
title('Local means (water holes)')

sum(sum(Dmin))
