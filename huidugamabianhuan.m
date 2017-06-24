%gamma变换
%gamma>1: 高灰度区域对比度增强
%gamma=1： 线性不该变图像
%gamma<1: 低灰度区域对比度增强
I=imread('lena.jpg');
%gamma=0.75
subplot(1,3,1);
imshow(imadjust(I,[],[],0.75));  %[][]默认0-1
title('gamma=0.75');
%gamma=1
subplot(1,3,2);
imshow(imadjust(I,[],[],1));
title('gamma=1');
%gamma=1.5
subplot(1,3,3);
imshow(imadjust(I,[],[],1.5));
title('gamma=1.5');