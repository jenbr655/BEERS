close all
im = imread('Snap_002.jpg');
im = rgb2gray(im);
im = imresize(im, 0.5);

binvect = 0:1:255;
histo = hist(im(:),binvect); %Histogram of original im

T = graythresh(im); %Find grayscale threshold using the Otsu-method
imbin = imbinarize(im,T);
imbin = ~imbin;

%Closing and opening algorithm for removal of hairs
se = strel('disk',4);
imC = imclose(imbin, se);
imO = imopen(imC,se);
for i = 1:4
imO = imerode(imO,se);
%imO = imdilate(imO,se);
end

BW = bwareaopen(imO,1000); %Removes objects that have connections fewer than 1000 pixels
BWfill = imfill(BW,'holes'); %Fills holes 


%% Bin�rbilder
% figure
% subplot(221),imshow(imbin)
% subplot(222),imshow(imO)
% subplot(223),imshow(BW)
% subplot(224),imshow(BWfill)

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


