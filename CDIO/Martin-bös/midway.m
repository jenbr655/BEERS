function T = midway(im)

binvect = 0:1:255;
histo = hist(im(:),binvect);

f = 1:length(histo);
T0 = sum(histo.*f)/sum(histo);

T1 = sum(histo(1:T0).*f(1:T0))/sum(histo(1:T0));
T2 = sum(histo(T0:end).*f(T0:end))/sum(histo(T0:end));

T = (T1 + T2)/2;
end