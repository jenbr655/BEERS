%% Prova kod
close all

I = imread('underarm1.jpg');
pic = rgb2gray(I);
J = adapthisteq(pic, 'cliplimit', 0.08, 'Distribution','rayleigh'); %funktion som gör bättre kontrast

figure(2), colormap('gray')
imagesc(pic)

pic = J;

kernel = [1 2 1; 2 4 2; 1 2 1]/16; %filtrera ytterligare med kärna
pic = conv2(pic,kernel,'same');

idx3 = find(pic < 90);
pic(idx3) = 0;

idx4 = find(pic > 90);
pic(idx4) = 255;

figure(3), colormap(gray(256))
imagesc(pic)

% pic = bwmorph(pic, 'bothat',1);
% pic = 1-pic;
% pic = imclearborder(pic);
% pic = bwmorph(pic,'clean',3);
% pic = bwmorph(pic, 'tophat');
%
% figure, colormap(gray(256))
% imagesc(pic)

%% Tester
close all
clear all

pat = load('pat_averagefilt.mat');
pat = pat.pattern;
%pat = pat(5:14,5:14);


pat2 = load('pattern_nail.mat');
pat2 = pat2.pattern_nail;

vec = [];
str = {};
files = dir('*.jpg');  % specigy the extension of your image file
for i = 1:numel(files);
    filename = files(i).name;
    image = imread(filename);
    % apply processing to the loaded image
    % save the image to an array or back to the folder using
    %%%%%%%%%%% Area%%%%%%%%%%%%%%
    J = rgb2gray(image);
    J = adapthisteq(J, 'cliplimit', 0.08, 'Distribution','rayleigh'); %funktion som gör bättre kontrast
    
    
    idx3 = find(J < 70);
    J(idx3) = 0;
    
    idx4 = find(J > 70);
    J(idx4) = 255;
    
    value=size(J);
    black_pix=sum(J(:) == 0);
    tot_pix=value(1)*value(2);
    vessel_dens=(black_pix/tot_pix)*100
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    pic = rgb2gray(image);
    kernel = [1 2 1; 2 4 2; 1 2 1]/16; %filtrera ytterligare med kärna
    pic = conv2(pic,kernel,'same');
    
    rescorr_ndc = corrdc(pic,pat); %normalized correlation without DC-level
    %rescorr_ndc = imclearborder(rescorr_ndc);
    fact4 = 0.2;
    rescorrT_ndc = rescorr_ndc>(max(rescorr_ndc(:))*fact4);
    
    rescorrT_ndc = imclearborder(rescorrT_ndc);
    
    figure(i)
    colormap(gray(256))
    imagesc(double(pic)+100*rescorrT_ndc);
    axis image; title(['Segmented vessels ', filename]); colorbar;
    
    
    S = bwmorph(rescorrT_ndc,'shrink',Inf);
    S = imfill(S,'holes');
    S = bwmorph(S,'shrink',Inf);
    vec = [vec; sum(sum(S))];
    
    filename
    
    figure(i+100)
    imagesc(S)
    axis image; title(['Number of vessels (', filename,'): ', num2str(sum(sum(S)))]); colorbar;
    
    figure(i+200)
    imagesc(J)
    axis image; title(['Number of vessels (', filename,'): ', num2str(sum(sum(S)))]); colorbar;
    
    str{end +1} = filename;
end


%%%%%%%%%%%%%%%%% Orakad%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hand1_manual = 90;
overarm1_manual = 42;
underarm2_manual = 65;
underarm1_manual = 144;
hand2_manual = 97;
%hadn1_manual = 125; Dublett av hand1 med två olika värden, intressant
overarm2_manual = 86;

manual_calc = [hand1_manual; hand2_manual; overarm1_manual; overarm2_manual;...
    underarm1_manual; underarm2_manual];

proc_diff = vec./manual_calc;

x = 1:length(proc_diff);
y = proc_diff;
%str = {'hand1','hand2', 'overarm1', 'overarm2','underarm1', 'underarm2'};

figure
stem(proc_diff)
xlim([0 8]), title('Difference between manual calculations of vessels and software (%)')
ylabel('%'), xlabel('Image')
dx = 0.1; dy = 0.1; % displacement so the text does not overlay the data points
text(x+dx, y+dy,str);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
