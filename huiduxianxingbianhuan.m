  %附件实例灰度线性变换   
  %可以调节整体对比度
I0 = imread('秦勤1.jpg');		% 读入原图像
I = rgb2gray(I0);%彩色图像不能直接直方图
%I=imresize(I0,0.25);%缩小显示

I = im2double(I);			
% 转换数据类型为double,所以后面涉及到与它进行运算的时候，都要转换到0~1的范围
[M,N] = size(I);			% 计算图像面积

figure(1);				% 打开新窗口
imshow(I);				% 显示原图像
title('原图像');

figure(2);				% 打开新窗口
[H,x] = imhist(I, 64);		% 计算64个小区间的灰度直方图
stem(x, (H/M/N), '.');		% 显示原图像的直方图???(H/M/N)
title('原图像');

% 增加对比度
Fa = 2; Fb = -55;
O = Fa .* I + Fb/255;%  .*  表示矩阵对应元素相乘

figure(3);
subplot(2,2,1);
imshow(O);
title('Fa = 2 Fb = -55 增加对比度');

figure(4);
subplot(2,2,1);
[H,x] = imhist(O, 64);
stem(x, (H/M/N), '.');
title('Fa = 2 Fb = -55 增加对比度');

% 减小对比度
Fa = 0.5; Fb = -55;
O = Fa .* I + Fb/255;

figure(3);
subplot(2,2,2);
imshow(O);
title('Fa = 0.5 Fb = -55 减小对比度');

figure(4);
subplot(2,2,2);
[H,x] = imhist(O, 64);
stem(x, (H/M/N), '.');
title('Fa = 0.5 Fb = -55 减小对比度');

% 线性增加亮度
Fa = 1; Fb = 55;
O = Fa .* I + Fb/255;

figure(3);
subplot(2,2,3);
imshow(O);
title('Fa = 1 Fb = 55 线性平移增加亮度');

figure(4);
subplot(2,2,3);
[H,x] = imhist(O, 64);
stem(x, (H/M/N),'.');
title('Fa = 1 Fb = 55 线性平移增加亮度');

% 反相显示
Fa = -1; Fb = 255;
O = Fa .* I + Fb/255;

figure(3);
subplot(2,2,4);
imshow(O);
title('Fa = -1 Fb = 255 反相显示');

figure(4);
subplot(2,2,4);
[H,x] = imhist(O, 64);
stem(x, (H/M/N), '.');
title('Fa = -1 Fb = 255 反相显示');
