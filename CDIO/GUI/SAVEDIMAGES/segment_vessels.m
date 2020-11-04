I=imread('annasnagelband.jpg');
gray_pic = rgb2gray(I);
J=adapthisteq(gray_pic, 'cliplimit', 0.08, 'Distribution','rayleigh');

figure(1)
imshowpair(gray_pic,J,'montage');

T = graythresh(J); %Find grayscale threshold using the Otsu-method
imbin = imbinarize(J,T);
imbin = imbin;

se = strel('disk',4);
% imC = imclose(imbin, se);
% imO = imopen(imC,se);
% for i = 1:2
% imO = imdilate(imO,se);
% %imO = imdilate(imO,se);
% end
se2 = strel('disk',2);
hairs = imtophat(gray_pic,se2);
T = graythresh(hairs);
hairsbin = imbinarize(hairs,T);


figure(3);
imshow(hairsbin)

