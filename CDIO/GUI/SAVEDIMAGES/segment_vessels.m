%Det här scriptet är en början på att segmentera kärlträdet
%Både segmentering av loopar i nagelband och små pluttar på underarm

I=imread('annasnagelband.jpg');
gray_pic = rgb2gray(I);
J=adapthisteq(gray_pic, 'cliplimit', 0.08, 'Distribution','rayleigh'); %funktion som gör bättre kontrast 

figure(1)
imshowpair(gray_pic,J,'montage'); %Plotta orginal mot resultat
colorbar



%% MARTINS BÖS
% T = graythresh(J); %Find grayscale threshold using the Otsu-method
% imbin = imbinarize(J,T);
% imbin = imbin;
% 
% se = strel('disk',4);
% % imC = imclose(imbin, se);
% % imO = imopen(imC,se);
% % for i = 1:2
% % imO = imdilate(imO,se);
% % %imO = imdilate(imO,se);
% % end
% se2 = strel('disk',2);
% hairs = imtophat(gray_pic,se2);
% T = graythresh(hairs);
% hairsbin = imbinarize(hairs,T);
% 
% 
% figure(3);
% imshow(hairsbin)

kernel = [1 2 1; 2 4 2; 1 2 1]/16; %filtrera ytterligare med kärna
J = conv2(J,kernel,'same');
N = 1;
for k=1:N
    J = conv2(J, kernel, 'same');
end

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

A=imread('vesselsunderarm2.jpg'); %Samma sak fast för underarm 
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
