%�Ҷ�ֱ��ͼ
I = imread('1.jpg');
I = rgb2gray(I);%��ɫͼ����ֱ��ֱ��ͼ
I0=imresize(I,0.25);%��С��ʾ
figure;
imshow(I0);title('Source');
%ֱ��ͼ
figure;
imhist(I0);title('Graph');%unit8�洢��ʽ��0-255

%��һ��ֱ��ͼ
[M,N] = size(I0);
[counts,x]=imhist(I,32);
counts = counts/M/N;
stem(x,counts);%��һ��ֱ��ͼ
