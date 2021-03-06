%% Script for calculating vessel density, both in units of percent and number of vessels in picture

function [vessel_dens,ves_num]= Seg_ves_func(area)

I = imread('current_pic.jpg');                          %Read the current pic
gray_pic = rgb2gray(I);                                 %Convert image to gray scale
J = adapthisteq(gray_pic, 'cliplimit', 0.08, 'Distribution','rayleigh'); %Use for better contrast in image

kernel = [1 2 1; 2 4 2; 1 2 1]/16;
J = conv2(J,kernel,'same');                             %Filter with kernel


idx3 = find(J < 55);                                    %Find pixels under threshold
J(idx3) = 0;                                            %Set pixels to zero

idx4 = find(J > 55);                                    %Find pixels above threshold
J(idx4) = 255;                                          %Set pixels to 255


%% Calculate number of vessels in image, use different pattern depending on area of measurement

if area == 2                                            %Arm measurement
    pat = load('pat_averagefilt.mat');
    pat = pat.pattern
end

if area == 1                                            %Nail measurement
    pat = load('pattern_nail.mat')
    pat = pat.pattern_nail
end

if area == 0
    vessel_dens = 'Choose area';
    ves_num = 'Choose area';
end


%% Compare image to pattern of vessels

rescorr_ndc = corrdc(gray_pic,pat);                     %Normalized correlation without DC-level
fact4 = 0.2;                                            %Pre-determined value 
rescorrT_ndc = rescorr_ndc>(max(rescorr_ndc(:))*fact4); %Binary image creation

S = bwmorph(rescorrT_ndc,'shrink',Inf);                 %Shrink to one pixel
S = imfill(S,'holes');                                  %Fill holes
S = bwmorph(S,'shrink',Inf);                            %Shrink to one pixel

ves_num = sum(sum(S));                                  %Calculate how many vessels in image

imwrite(J,'boundary_pic.jpg')

%% Calculate density in units of percentage

sz=load('current_pic.mat');                             %Calculate on current pic
value=size(J)
black_pix=sum(J(:) == 0)                                %Count number of black pixels
tot_pix=value(1)*value(2);                              %Calculate total pixels
vessel_dens=(black_pix/tot_pix)*100                     %Calculate density [%]

end

