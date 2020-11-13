function [T,T1,T2] = midway(im,thresh)

binvect = 0:1:255;
histo = hist(im(:),binvect);

if nargin < 2
    
    f = 1:length(histo);
    T0 = sum(histo.*f)/sum(histo);
    
    T1 = sum(histo(1:T0).*f(1:T0))/sum(histo(1:T0));
    T2 = sum(histo(T0:end).*f(T0:end))/sum(histo(T0:end));
    
    T = (T1 + T2)/2;
    
else
    f = 1:length(histo);
    T0 = sum(histo.*f)/sum(histo);
    
    T1 = sum(histo(1:thresh).*f(1:thresh))/sum(histo(1:thresh));
    T2 = sum(histo(thresh:end).*f(thresh:end))/sum(histo(thresh:end));
    
    T = (T1 + T2)/2;
    
end