  %����ʵ���Ҷ����Ա任   
  %���Ե�������Աȶ�
I0 = imread('����1.jpg');		% ����ԭͼ��
I = rgb2gray(I0);%��ɫͼ����ֱ��ֱ��ͼ
%I=imresize(I0,0.25);%��С��ʾ

I = im2double(I);			
% ת����������Ϊdouble,���Ժ����漰���������������ʱ�򣬶�Ҫת����0~1�ķ�Χ
[M,N] = size(I);			% ����ͼ�����

figure(1);				% ���´���
imshow(I);				% ��ʾԭͼ��
title('ԭͼ��');

figure(2);				% ���´���
[H,x] = imhist(I, 64);		% ����64��С����ĻҶ�ֱ��ͼ
stem(x, (H/M/N), '.');		% ��ʾԭͼ���ֱ��ͼ???(H/M/N)
title('ԭͼ��');

% ���ӶԱȶ�
Fa = 2; Fb = -55;
O = Fa .* I + Fb/255;%  .*  ��ʾ�����ӦԪ�����

figure(3);
subplot(2,2,1);
imshow(O);
title('Fa = 2 Fb = -55 ���ӶԱȶ�');

figure(4);
subplot(2,2,1);
[H,x] = imhist(O, 64);
stem(x, (H/M/N), '.');
title('Fa = 2 Fb = -55 ���ӶԱȶ�');

% ��С�Աȶ�
Fa = 0.5; Fb = -55;
O = Fa .* I + Fb/255;

figure(3);
subplot(2,2,2);
imshow(O);
title('Fa = 0.5 Fb = -55 ��С�Աȶ�');

figure(4);
subplot(2,2,2);
[H,x] = imhist(O, 64);
stem(x, (H/M/N), '.');
title('Fa = 0.5 Fb = -55 ��С�Աȶ�');

% ������������
Fa = 1; Fb = 55;
O = Fa .* I + Fb/255;

figure(3);
subplot(2,2,3);
imshow(O);
title('Fa = 1 Fb = 55 ����ƽ����������');

figure(4);
subplot(2,2,3);
[H,x] = imhist(O, 64);
stem(x, (H/M/N),'.');
title('Fa = 1 Fb = 55 ����ƽ����������');

% ������ʾ
Fa = -1; Fb = 255;
O = Fa .* I + Fb/255;

figure(3);
subplot(2,2,4);
imshow(O);
title('Fa = -1 Fb = 255 ������ʾ');

figure(4);
subplot(2,2,4);
[H,x] = imhist(O, 64);
stem(x, (H/M/N), '.');
title('Fa = -1 Fb = 255 ������ʾ');
