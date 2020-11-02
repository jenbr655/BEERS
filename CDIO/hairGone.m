close all

im = imread('Snap_004.jpg');
im = rgb2gray(im);
%im = imresize(im, 0.5);

binvect = 0:1:255;
histo = hist(im(:), binvect);

sigma = 2;
lpH=exp(-0.5*([-9:9]/sigma).^2); 
lpH=lpH/sum(lpH); % Horizontal filter 
lpV=lpH'; % Vertical filter
im_gauss = conv2(conv2(im,lpV,'same'),lpH,'same');

se2 = strel('disk',2);
hairs = imtophat(im,se2);

imagesc(hairs)

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
%interpol = interp(im,idx);  %Hittar idx i originalbilden och sätter till medelvärde av omkringliggande pixlar
interpol = interp2(im,idx);

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


