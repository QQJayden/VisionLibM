%�Ҷ�ͼ���Ե
%I=imread('FigP1036(blobs).tif');
I=imread('����1.jpg');
I = rgb2gray(I);%��ɫͼ��

%imshow(I);title('ԭͼ��');
% �����ݶ�����
bw1=edge(I,'roberts');
bw2=edge(I,'sobel');
bw3=edge(I,'prewitt');
bw4=edge(I,'log');
bw5=edge(I,'canny');

subplot(2,3,1);imshow(I);title('ԭͼ��');
subplot(2,3,2);imshow(bw1);title('roberts');
subplot(2,3,3);imshow(bw2);title('sobel');
subplot(2,3,4);imshow(bw3);title('prewitt');
subplot(2,3,5);imshow(bw4);title('log');
subplot(2,3,6);imshow(bw5);title('canny');
