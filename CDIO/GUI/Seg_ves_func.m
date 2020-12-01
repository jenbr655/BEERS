%New function for calculation of vessel density, gives vessel denstiy in
%percent
function [vessel_dens,ves_num]= Seg_ves_func(area)

I = imread('current_pic.jpg');
gray_pic = rgb2gray(I);
J = adapthisteq(gray_pic, 'cliplimit', 0.08, 'Distribution','rayleigh'); %funktion som gör bättre kontrast 

idx3 = find(J < 70);
J(idx3) = 0;

idx4 = find(J > 70);
J(idx4) = 255;

kernel = [1 2 1; 2 4 2; 1 2 1]/16; %filtrera ytterligare med kärna
gray_pic = conv2(gray_pic,kernel,'same');


%%
area
if area == 2
    pat = load('pat_averagefilt.mat');
    pat = pat.pattern
end

if area == 1
    pat = load('pattern_nail.mat')
    pat = pat.pattern_nail
end

% pat = load('pat_averagefilt.mat')
% pat = pat.pattern;
% 
% pat2 = load('pattern_nail.mat');
% pat2 = pat2.pattern_nail;

%%
rescorr_ndc = corrdc(gray_pic,pat); %normalized correlation without DC-level
fact4 = 0.2;
rescorrT_ndc = rescorr_ndc>(max(rescorr_ndc(:))*fact4);

S = bwmorph(rescorrT_ndc,'shrink',Inf);
S = imfill(S,'holes');
S = bwmorph(S,'shrink',Inf);

ves_num = sum(sum(S));

figure(55);
colormap(gray(256))
imagesc(J);
axis image; title('Vessel area in black'); colorbar;

D=figure(55);
saveas(D,'boundary_pic.jpg')

sz=load('current_pic.mat');
value=size(J)
black_pix=sum(J(:) == 0)
tot_pix=value(1)*value(2);
vessel_dens=(black_pix/tot_pix)*100

end

