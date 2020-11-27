function newImage = interp(im,idx)

[rows,cols] = size(im);
N = 100;
theta = linspace(0, 2*pi, N+1);
theta(end) = [];
R = 10; %linspace(0,10, length(theta));

for j = 1:length(idx)
    [row,col] = ind2sub(size(im),idx(j));
    xff = row;
    yff = col;
    [x, y] = pol2cart(theta,R);
    x = x + xff;
    y = y + yff;
    y(y == 0) = 1; %Indexeringskäl senare
    x(x == 0) = 1; %Indexeringskäl senare
    figure(123), imagesc(im), hold on
    plot(x,y)
    %plot(xff,yff, 'LineWidth',4)
    hold off
    %vals = interp2(ones(10,10),x,y);
    if(length(x(x < 0))~= 0 || length(y(y < 0)) ~= 0 || length(x(x > rows)) || length(y(y > cols)))
        im(xff,yff) = mean(mean(im));
        %newImage(xff,yff) = im(xff,yff);
    else if(max(x)< rows && max(y)< cols)
            im(xff,yff) = mean(mean(im(ceil(x),ceil(y))));
        end
    end
    newImage = im;
end
