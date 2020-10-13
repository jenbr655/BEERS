close all

im = imread('Snap_004.jpg');
im = rgb2gray(im);
im = imresize(im, 0.5);

binvect = 0:1:255;
histo = hist(im(:), binvect);

sigma = 2;
lpH=exp(-0.5*([-9:9]/sigma).^2); 
lpH=lpH/sum(lpH); % Horizontal filter 
lpV=lpH'; % Vertical filter
im_gauss = conv2(conv2(im,lpV,'same'),lpH,'same');

se = strel('disk',2);
hairs = imtophat(im,se);

imagesc(hairs)

T = graythresh(hairs);
hairsbin = imbinarize(hairs,T);

imagesc(hairsbin), colorbar

im_gauss(hairsbin > 0) = mean(mean(im_gauss));
im(hairsbin > 0) = mean(mean(im_gauss));

figure
subplot(121),imagesc(im_gauss), colormap(gray(256)),colorbar
subplot(122), imagesc(im)

