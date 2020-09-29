close all
im = imread('Snap_004.jpg');
im = rgb2gray(im);
im2 = imread('Snap_002.jpg');
im2 = rgb2gray(im2);

%Skapa egen colormap
mycolormap0 = gray(256);
mycolormapR = mycolormap0;
mycolormapR(201:256,:) = ones(56,1)*[1 0 0];
mycolormapGB = mycolormap0;
mycolormapGB(100:150,:) = ones(51,1)*[0 0 1];
mycolormapGB(201:256,:) = ones(56,1)*[0 0 1];

binvect = 0:1:255;
histo = hist(im(:), binvect);

aver = [1 2 1; 2 4 2; 1 2 1] /16; %Medelvärdesfilter
aver_im = conv2(im, aver, 'same');
for i = 1:100
    aver_im = conv2(aver_im, aver, 'same'); %Medelvärdesfiltrering flera gånger
end

IM = fftshift(fft2(ifftshift(im))); %Fourier transform
maxIM = max(max(abs(IM)));

%Deriverande filter i x- och y-led
sobely = [1; 0; -1]/2;
cdx = [1 0 -1]/2;
imY =  conv2(im2, sobely,'same');
imX =  conv2(im2, cdx,'same');
magngradIM = sqrt(imY.^2+imX.^2); %Storlek på deriveringen (magnitude)

%Laplacefilter = högpassfilter
laplace = [0 1 0; 1 -4 1; 0 1 0];
im_laplace = conv2(im2, laplace, 'same');

%Hitta rätt tröskelvärde för binär bild
startT = find(histo, 1, 'first');
mid_way_T = mid_way(histo,startT);
least_error_T = least_error(histo,mid_way_T);

imT = (aver_im>least_error_T);

im_new = 50*double(imT) + double(im);



