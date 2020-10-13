function newImage = interp(im,idx)

[rows,cols] = size(im);
new_im = zeros(rows,cols);

im(idx) = mean(mean(im));
newImage = im;
end
