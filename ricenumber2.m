%��ֵ��ʱ���е�����ֱ�ӱ��ָ�
clear;
close all;
I=imread('rice.png');
figure,imshow(I);
%P=impixel(I);
I=edge(I,'canny');
figure,imshow(I);
I=imfill(I,'holes');

%������
%SE=strel('square',5);
SE=strel('disk',3);
I=imopen(I,SE);%������
% SE=strel('square',1);
% I=imclose(I,SE);%�ղ���
figure,imshow(I);
 
% %��ֵ��
% thresh=graythresh(I);           %����Ӧ��ֵ
% L=im2bw(I,thresh);                  %��ֵ��,levelȡֵ0-1
% %L=bwareaopen(L,50);    %ȥ��ͼ���������С��,���е�����ֱ�ӱ�
% figure,imshow(L);

[width,height]=size(I);
E=0;N=0;  %E��ʾ�����Ŀ��N��ʾ�ڽ���Ŀ
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