close all

I = imread('nagelband2.jpg');
gray_pic = rgb2gray(I);
J = adapthisteq(gray_pic, 'cliplimit', 0.08, 'Distribution','rayleigh'); %funktion som gör bättre kontrast 

figure(1), %colormap(gray(256))
imshowpair(gray_pic,J,'montage'); %Plotta orginal mot resultat
colorbar

kernel = [1 2 1; 2 4 2; 1 2 1]/16; %filtrera ytterligare med kärna
J = conv2(J,kernel,'same');
N = 3;
for k=1:N
    J = conv2(J, kernel, 'same');
end

gray_pic = conv2(gray_pic,kernel,'same');

figure, colormap(gray(256))
imagesc(gray_pic)

[T,T1,T2] = midway(J);
[~,T1,~] = midway(J,T1);
imbinJ = imbinarize(J,T1);


%%
pattern = gray_pic(353-99:353+99,310-99:310+99);
pattern = pattern(104-10:104+9,99-10:99+9);

filename = 'pattern.mat';
save('pattern', 'pattern')

figure, colormap(gray(256))
imagesc(pattern)


%%
pat = load('pat_averagefilt.mat');
pat = pat.pattern;

%%
rescorr_n = corrn(gray_pic,pat); %Normalized correlation
fact2 = 0.95;
rescorrT_n = rescorr_n>(max(rescorr_n(:))*fact2);

figure
colormap(gray(256))
axis image; title('pattern'); colorbar;
subplot(1,2,1), imagesc(rescorr_n);
axis image; title('result corr'); colorbar;
subplot(1,2,2), imagesc(double(gray_pic)+255*rescorrT_n);
axis image; title('thresh corr'); colorbar;

%%
rescorr_dc = corrdc(gray_pic,pat); %Corr without local DC-level
fact3 = 0.2;
rescorrT_dc = rescorr_dc>(max(rescorr_dc(:))*fact3);

figure
colormap(gray(256))
axis image; title('pattern'); colorbar;
subplot(1,2,1), imagesc(rescorr_dc);
axis image; title('result corr'); colorbar;
subplot(1,2,2), imagesc(double(gray_pic)+255*rescorrT_dc);
axis image; title('thresh corr'); colorbar;
%%
rescorr_ndc = corrdc(gray_pic,pat); %normalized correlation without DC-level
fact4 = 0.2;
rescorrT_ndc = rescorr_ndc>(max(rescorr_ndc(:))*fact4);

figure
colormap(gray(256))
axis image; title('pattern'); colorbar;
subplot(1,2,1), imagesc(rescorr_ndc);
axis image; title('result corr'); colorbar;
subplot(1,2,2), imagesc(double(gray_pic)+255*rescorrT_ndc);
axis image; title('thresh corr'); colorbar;

S = bwmorph(rescorrT_ndc,'shrink',Inf);
sum(sum(S))
figure
imagesc(S)









