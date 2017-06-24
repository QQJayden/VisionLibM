%灰度阈值变换：将灰度图像转化为二值图像
I=imread('西西里.jpg');
thresh=graythresh(I);%自适应确定阈值,结果138

bw1=im2bw(I,thresh);%二值化

bw2=im2bw(I,65/255);%以130为阈值，【0，1】，
%？？？为何减小阈值，图中黑色区域反而减少
%因为0表示黑！！！
subplot(1,3,1);imshow(I);title('原图像');
subplot(1,3,2);imshow(bw1);title('自适应阈值');
subplot(1,3,3);imshow(bw2);title('阈值130');