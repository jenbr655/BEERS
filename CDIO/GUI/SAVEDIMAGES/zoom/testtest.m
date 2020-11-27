filename = '20201126T173939.mat';
I= load(filename);

I= struct2cell(I);
I= cell2mat(I);

imshow(I);
axis on;