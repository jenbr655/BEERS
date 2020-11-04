close all;
clear all;

cam=webcam('USB 2760 Camera');
preview(cam)

%Behöver lägga in i gui_t här när den ska ta bilden. Typ loop/paus tills
%man trycker på knapp. 
pause(10);
img=snapshot(cam);
img_gray=rgb2gray(img);
im = imresize(img_gray, 0.5);


figure(13)
imshow(im)

% figure(13)
% subplot(131)
% imshow(im)
% subplot(132)
% imshow(img_gray)

%% Segmentation

binvect = 0:1:255;
histo = hist(img_gray(:), binvect);

T = graythresh(img_gray);
imbin = imbinarize(img_gray,T);
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
imshow(img_gray);
hold on;
for k = 1:length(B),
    boundary = B{k};
    if(k > N)
        %plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
    else
        plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
    end
end

%% Area

tot_area=bwarea(BWfill) %total area in pixels 

num_one=sum(BWfill(:)==1) %how many ones i matrix

[x_val y_val]=size(BWfill); %size of picture
tot_num_pix=x_val*y_val;

num_one_of_tot=num_one/tot_num_pix; %procent of how many pixels that are white

area_mole=tot_area*num_one_of_tot %area in pixels that are white

%F�r att detta ska fungera beh�ver vi nu veta storleken av en pixel och det
%beror p� inzoomning osv. 
