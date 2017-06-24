%二值化时，有的米粒直接被分割
clear;
close all;
I=imread('rice.png');
figure,imshow(I);
%P=impixel(I);
I=edge(I,'canny');
figure,imshow(I);
I=imfill(I,'holes');

%开操作
%SE=strel('square',5);
SE=strel('disk',3);
I=imopen(I,SE);%开操作
% SE=strel('square',1);
% I=imclose(I,SE);%闭操作
figure,imshow(I);
 
% %阈值化
% thresh=graythresh(I);           %自适应阈值
% L=im2bw(I,thresh);                  %二值化,level取值0-1
% %L=bwareaopen(L,50);    %去除图像中面积过小的,但有的米粒直接被
% figure,imshow(L);

[width,height]=size(I);
E=0;N=0;  %E表示外角数目；N表示内角数目
for i=1:(height-1)
    for j=1:(width-1)
        if external_match(I,i,j)==1 
            E=E+1;
        elseif internal_match(I,i,j)==1
            N=N+1;
        end
    end
end
sum=(E-N)/4;