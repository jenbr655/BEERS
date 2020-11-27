close all
im = imread('Snap_003.jpg');
im = rgb2gray(im);
im = double(im);
im = im/max(max(im)); %The graythresh-function takes values between [0 1]
im = imresize(im, 0.5);

%% Circular convolution, average filtering
sigma = 2;
lpH=exp(-0.5*([-3:3]/sigma).^2); 
lpH=lpH/sum(lpH); %Horizontal filter 
lpV=lpH'; %Vertical filter
gauss = conv2(lpV,lpH,'full'); %Gaussian filter

gausskern =0*im; %Array of zeros
%center = size(im,1)/2+1;
[row,col] = size(im);

centerx = row/2; %Center row
centery = col/2; %Center column

gausskern(centerx-3:centerx+3, centery-3:centery+3) = gauss; %Centering Gaussian filter in the image before transform 
IM = fftshift(fft2(ifftshift(im))); %Fourier transform of im
GAUSSKERN = fftshift(fft2(ifftshift(gausskern))); %Fourier transorm of averageing kernel
AVERIM = IM.*GAUSSKERN; %Filtering in the fourier domain => averaged image
averim = real(fftshift(ifft2(ifftshift(AVERIM)))); %Filtered image

%%
im = averim;
binvect = 0:1:255;
histo = hist(im(:),binvect); %Histogram of original im

T = graythresh(im); %Find grayscale threshold using the Otsu-method
imbin = imbinarize(im,T); %Make binary image
imbin = ~imbin; %Change white to black and vice versa

%Closing and opening algorithm for removal of hairs
se = strel('disk',4);
imC = imclose(imbin, se); %Performs closing
imO = imopen(imC,se); %Performs opening
for i = 1:4
imO = imerode(imO,se);
%imO = imdilate(imO,se);
end

BW = bwareaopen(imO,10); %Removes objects that have connections fewer than 1000 pixels
BWfill = imfill(BW,'holes'); %Fills holes 


%% Bin�rbilder
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



