%% Subtraction of images 

%May be used to calculate how far a RBC have travelled if you take two
%pictures close in time with good resolution 

im1=imread('subim1.png'); %image 1 
im2=imread('subim2.png'); % image 2

sub_im=imsubtract(im1, im2); % subtraction of image 1 and 2 

figure(1)
imshow(sub_im)


