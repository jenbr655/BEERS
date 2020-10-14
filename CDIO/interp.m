function newImage = interp(im)

new_im = zeros(rows,cols);
idx = find(im > 0);

for i = length(idx)
[row_idx, col_idx] = ind2sub(size(idx),i);
im(idx(i)) = mean(mean(row_idx-10:row_idx+10,col_idx - 10:col_idx + 10));
end
new_im = im;
end



