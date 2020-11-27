close all
I=imread('nagelband2.jpg');
J2 = rgb2gray(I);
J2 = adapthisteq(J2, 'cliplimit', 0.08, 'Distribution','rayleigh');
J2 = double(J2);
J2 = imresize(J2, 1);
%J2 = J2/max(max(J2));


%% Circular convolution, average filtering
sigma = 2;
lpH=exp(-0.5*([-3:3]/sigma).^2); 
lpH=lpH/sum(lpH); %Horizontal filter 
lpV=lpH'; %Vertical filter
gauss = conv2(lpV,lpH,'full'); %Gaussian filter

gausskern =0*J2; %Array of zeros
%center = size(im,1)/2+1;
[row,col] = size(J2);

centerx = row/2; %Center row
centery = col/2; %Center column

gausskern(centerx-3:centerx+3, centery-3:centery+3) = gauss; %Centering Gaussian filter in the image before transform 
IM = fftshift(fft2(ifftshift(J2))); %Fourier transform of im
GAUSSKERN = fftshift(fft2(ifftshift(gausskern))); %Fourier transform of averageing kernel
AVERIM = IM.*GAUSSKERN; %Filtering in the fourier domain => averaged image
for i = 1:7
    AVERIM = IM.*GAUSSKERN;
end
averim = real(fftshift(ifft2(ifftshift(AVERIM)))); %Filtered image

kernel = [1 2 1; 2 4 2; 1 2 1] / 16;
kernel = conv2(conv2(kernel,kernel,'full'),kernel, 'full');
kernelkern = 0*J2;

kernelkern(centerx-3:centerx+3, centery-3:centery+3) = kernel;
KERNELKERN = fftshift(fft2(ifftshift(kernelkern))); %Fourier transform of kernel kernel 
KERNIM = IM.*KERNELKERN;
for i = 1:7
    KERNIM = IM.*KERNELKERN;
end
kernim =real(fftshift(ifft2(ifftshift(KERNIM))));
%%
%J2 = averim;
J2 = kernim;

[T,T1,T2] = midway(J2);
[~,T1,~] = midway(J2,T1);
imbin = imbinarize(J2,T1);
%se = [1 1 1; 1 1 1; 1 1 1];
%imbin = imerode(imbin,se);

figure
imshowpair(imbin, J2, 'montage')

%%
W = double(watershed(imbin));
Dmin = imregionalmin(imbin);
CC = bwconncomp(Dmin,4);
figure, imagesc(W);
colormap(colorcube(300)), colorbar;
title('Watershed transform of D')

%%
ImLabel = labelmatrix(CC);
figure, imagesc(ImLabel);
colormap(colorcube(300)), colorbar;
title('Local means (water holes)')

VesselNum = CC.NumObjects;

S = bwmorph(ImLabel,'shrink',Inf);
figure, imagesc(S);
colormap(colorcube(300)), colorbar;
title('Skeleton')

%%
%Det här scriptet är en början på att segmentera kärlträdet
%Både segmentering av loopar i nagelband och små pluttar på underarm

I=imread('vesselsunderarm.jpg');
gray_pic = rgb2gray(I);
J=adapthisteq(gray_pic, 'cliplimit', 0.08, 'Distribution','rayleigh'); %funktion som gör bättre kontrast 

figure(1)
imshowpair(gray_pic,J,'montage'); %Plotta orginal mot resultat
colorbar

kernel = [1 2 1; 2 4 2; 1 2 1]/16; %filtrera ytterligare med kärna
J = conv2(J,kernel,'same');
N = 3;
for k=1:N
    J = conv2(J, kernel, 'same');
end

[T,T1,T2] = midway(J);
[~,T1,~] = midway(J,T1);
imbinJ = imbinarize(J,T1);

figure
imshow(imbinJ);

%% AMANDAS BÖS
% J=double(J);

% for i=1:640
%     for j=480
% if J(j:i) < 200
%    J(j:i)=0;
% end 
%     end
% end

idx = find(J < 100); %Ändra alla värden i bilden som är under ett visst värde till 0
J(idx) = 0;

idx2 = find(J > 100); %ändra alla värden över ett visst värde till 255
J(idx2) = 255;
% J=J/(max(max(J)));

figure(5)
imshow(J)

%% JOBB PÅ UNDERARM ISTÄLLET FÖR NAGELBAND


A=imread('vesselsunderarm.jpg'); %Samma sak fast för underarm 
gray_pic_underarm = rgb2gray(A);
B=adapthisteq(gray_pic_underarm, 'cliplimit', 0.045, 'Distribution','rayleigh');

figure(6)
imshowpair(gray_pic_underarm,B,'montage');
colorbar


idx3 = find(B < 90);
B(idx3) = 0;

idx4 = find(B > 90);
B(idx4) = 255;

figure(7)
imshow(B)


%% Räkna hur stor andel pixlar som är svarta ifrån underarmsbild

black_pix=sum(B(:)==0)

