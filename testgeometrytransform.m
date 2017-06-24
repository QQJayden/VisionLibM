%如何对所有彩色图像适用
%对索引图像适用
%如何不丢失信息
%如何以矩阵形式表示所有变换
%% 
%目前算法只考虑灰度图像
%% 

% %图像平移：myimmove
% I=imread('lena.jpg');
% I0=myimmove(I,[100,30]);  %第二个量表示移动向量，单位为一个像素距离
% subplot(1,2,1);imshow(I);title('原图');
% subplot(1,2,2);imshow(I0),title('平移');
% %imshow问题：之前需要除256，新的函数则不需要
% %imshow的bug

%图像镜像&转置：myimmirror
I=imread('lena.jpg');
I1=myimmirror(I,'vertical');  
I2=myimmirror(I,'horizontal'); 
I3=myimmirror(I,'transpose');   %转置
subplot(2,2,1);imshow(I);title('原图');
subplot(2,2,2);imshow(I1),title('竖直');
subplot(2,2,3);imshow(I2),title('水平');
subplot(2,2,4);imshow(I3),title('错误');

%图像缩放

