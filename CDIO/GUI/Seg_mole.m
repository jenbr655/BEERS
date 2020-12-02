%% Script for segmenting moles

function [res]= Seg_mole()
im = imread('current_pic.jpg');     %Read the current picture
im = rgb2gray(im);                  %Convert picture to gray scale
im = imresize(im, 0.5);             %Resize picture for faster calculations


T = graythresh(im);                 %Find grayscale threshold using the Otsu-method
imbin = imbinarize(im,T);
imbin = ~imbin;


se = strel('disk',4);               %Closing and opening algorithm for removal of hairs
imC = imclose(imbin, se);
imO = imopen(imC,se);

for i = 1:3
    imO = imerode(imO,se);
end

imO = imdilate(imO,se);

BW = bwareaopen(imO,1000);          %Removes objects that have connections fewer than 1000 pixels
BWfill = imfill(BW,'holes');        %Fills holes

[B,L,N] = bwboundaries(BW);         %Find boundaries

boundry_line=figure;
imshow(im);
hold on;

for k = 1:length(B)                 %Boundary plot
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
end

saveas(boundry_line, 'boundary_pic.jpg');
close(boundry_line);

res=BWfill                          %Binary picture with ones where the mole is
end


