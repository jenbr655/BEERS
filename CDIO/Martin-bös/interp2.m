function newImage = interp2(im,idx)

[rows,cols] = size(im);
[r,c] = ind2sub(size(im), idx);
R = 10;
N = 100;
theta = linspace(0, 2*pi, N+1);
theta(end) = [];

[x, y] = pol2cart(theta,R);
x = x + r;
y = y + c;
x(x > cols) = [];
y(y > rows) = [];
x(x < 0) = [];
y(y < 0) = [];

im(r,c) = mean(mean(im(round(x),round(y))))

newImage = im;
end

