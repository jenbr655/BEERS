function [x, y] = hist_eq(im)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n_bins = max(max(im));
[h, b] = size(im);
n_pix = h * b;
hist = zeros([0,n_bins])
p_table = zeros([0,n_bins]);
L_table = zeros([0,n_bins]);

for i = 1:1:n_bins+1  
    hist(1,i) = sum(sum(im == i-1))
    p_table(1,i) = hist(1,i)/n_pix;
end

c_m = cumsum(p_table)
L_table = round(n_bins * c_m)
res = zeros(h, b)
for i = 1:1:length(L_table)
    curr_val = L_table(1,i)
    res = res + curr_val*(im == i-1)
end 
x = res 
y = L_table
end

