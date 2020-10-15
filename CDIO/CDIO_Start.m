close all
im = imread('medpol.jpg');
im = rgb2gray(im);
im = imresize(im, 0.5);

binvect = 0:1:255;
histo = hist(im(:), binvect);

T = graythresh(im);
imbin = imbinarize(im,T);
imbin = ~imbin;

se = strel('square',4);
imC = imclose(imbin, se);
imO = imopen(imC,se);
BW = bwareaopen(imO,1000);
BWfill = imfill(BW,'holes');

% laplace = [0 1 0; 1 -4 1; 0 1 0]/8;
% lap_im = conv2(im, laplace, 'same');
% lap_T = graythresh(lap_im);
% lap_bin = imbinarize(lap_im,lap_T);
% lap_bin = imopen(~lap_bin,se);
% lap_bin = bwareaopen(lap_bin, 10, 8);
% im(lap_bin < 1) = 0;
% mask = im == 0;
% newImage = imfill(mask,'holes');
% im = regionfill(im,newImage);

figure
imagesc(im), colorbar
%%
%Bin�rbilder
figure
subplot(221),imshow(imbin)
subplot(222),imshow(imO)
subplot(223),imshow(BW)
subplot(224),imshow(BWfill)

[B,L,N] = bwboundaries(BW);
figure;
imshow(BWfill);
hold on;
for k = 1:length(B),
    boundary = B{k};
    if(k > N)
        %plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
    else
        plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
    end
end

figure;
imshow(im);
hold on;
for k = 1:length(B),
    boundary = B{k};
    if(k > N)
        %plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
    else
        plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
    end
end


