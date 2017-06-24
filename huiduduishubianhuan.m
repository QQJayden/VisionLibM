%灰度对数变换-频谱图像的显示
%增强图像较暗部分的细节
%扩展被压缩高值图像中较暗像素

I=imread('lena.jpg');
F=fft2(im2double(I));%频谱,中心绝对高灰度
F=fftshift(F);
F=abs(F);
T=log(F+1);%对数变换

subplot(1,2,1);
imshow(F,[]); %空矩阵，默认最大最小灰度，灰度拉伸效果
title('变换前');

subplot(1,2,2);
imshow(T,[]);
title('变换后');


