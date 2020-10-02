close all
im = imread('Snap_004.jpg');
im = rgb2gray(im);
im2 = imread('Snap_002.jpg');
im2 = rgb2gray(im2);

binvect = 0:1:255;
histo = hist(im(:), binvect);

T = graythresh(im);
imbin = imbinarize(im,T);
imbin = ~imbin;

se = strel('square',4);
imC = imclose(imbin, se);
imO = imopen(imC,se);
BW = bwareaopen(imO,2000);
BWfill = imfill(BW,'holes');

figure
subplot(221),imshow(imC)
subplot(222),imshow(imO)
subplot(223),imshow(BW)
subplot(224),imshow(BWfill)

%B = bwboundaries(BWfill, 4);

[B,L,N] = bwboundaries(BW);
figure;
imshow(BW);
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


a = 1:5
