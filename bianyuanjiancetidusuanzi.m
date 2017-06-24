%灰度图像边缘
%I=imread('FigP1036(blobs).tif');
I=imread('秦勤1.jpg');
I = rgb2gray(I);%彩色图像

%imshow(I);title('原图像');
% 各种梯度算子
bw1=edge(I,'roberts');
bw2=edge(I,'sobel');
bw3=edge(I,'prewitt');
bw4=edge(I,'log');
bw5=edge(I,'canny');

subplot(2,3,1);imshow(I);title('原图像');
subplot(2,3,2);imshow(bw1);title('roberts');
subplot(2,3,3);imshow(bw2);title('sobel');
subplot(2,3,4);imshow(bw3);title('prewitt');
subplot(2,3,5);imshow(bw4);title('log');
subplot(2,3,6);imshow(bw5);title('canny');
