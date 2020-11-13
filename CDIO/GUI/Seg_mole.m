function [res]= Seg_mole()
im = imread('current_pic.jpg');
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
for i = 1:3
imO = imerode(imO,se);

end

imO = imdilate(imO,se);

BW = bwareaopen(imO,1000); %Removes objects that have connections fewer than 1000 pixels
BWfill = imfill(BW,'holes'); %Fills holes 

[B,L,N] = bwboundaries(BW);

boundry_line=figure;
imshow(im);
hold on;

for k = 1:length(B)
    boundary = B{k};
    if(k > N)
        %plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
    else
        plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
    end
end

saveas(boundry_line, 'boundary_pic.jpg');
close(boundry_line);

res=BWfill;
end


