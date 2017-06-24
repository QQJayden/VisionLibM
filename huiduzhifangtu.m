%灰度直方图
I = imread('1.jpg');
I = rgb2gray(I);%彩色图像不能直接直方图
I0=imresize(I,0.25);%缩小显示
figure;
imshow(I0);title('Source');
%直方图
figure;
imhist(I0);title('Graph');%unit8存储格式，0-255

%归一化直方图
[M,N] = size(I0);
[counts,x]=imhist(I,32);
counts = counts/M/N;
stem(x,counts);%归一化直方图
