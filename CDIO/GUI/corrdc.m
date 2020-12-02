%% Script for correlation calculation 

function  y = corrdc(img,pat)                   %Input is an image and a pattern

img = double(img);                              %Convert data into double
pat = double(pat);

[M,N] = size(img);                              %Check size, pattern size must be even
[Mp,Np] = size(pat);

if mod(Mp,2)== 1 | mod(Np,2)== 1
  error('pattern size must be even')
end

if (Mp>M) | (Np>N)
  error('pattern size must smaller or equal to image size')
end

pat = pat - mean(mean(pat));                    %Remove the mean from the pattern

rvec = round(M/2+1+[-Mp/2:Mp/2-1]);             % Zero-pad pattern
cvec = round(N/2+1+[-Np/2:Np/2-1]);
p1 = zeros(M,N);
p1(rvec,cvec) = pat;

F = fftshift(fft2(ifftshift(img)));             % Correlation in the Fourier domain
P = fftshift(fft2(ifftshift(p1)));
y = real(ifftshift(ifft2(fftshift(F.*conj(P)))));

