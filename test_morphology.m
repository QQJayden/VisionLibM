%% ��̬ѧͼ����
% ��ʴ��imerode(I,SE)
% ���ͣ�imdilate(I,SE)
% �����㣺imopen(I,SE)
% �����㣺imclose(I,SE)
% ���л����б任��bwhitmiss(I,S1,S2)

% SE:
% 'arbitrary'��Ϊ�������Զ���ĽṹԪ��
% 'disk�� Բ�νṹԪ��
% 'square' �����νṹԪ��
% 'rectangle�� ���νṹԪ��
% 'line�� ���εĽṹԪ��
% 'pair' ����2����ĽṹԪ��
% 'diamond' ���εĽṹԪ��
% 'octagon' 8���εĽṹԪ��

% ������̬ѧ������bwmorph(I, operation, n)
% imshow(I,'InitialMagnification','fit');

%% ��ʴ������

% I0 = sparse([2,3,3,3,4,4,5], [2,2,3,4,3,4,3],[1,1,1,1,1,1,1],6,6);
% I = full(I0);
% SE0 = sparse([3,3,4],[3,4,3],[1,1,1],6,6);
% SE = full(SE0);

% subplot(2,2,1);imshow(I);title('ԭͼ');
% subplot(2,2,2);imshow(SE);title('�ṹԪ');
% subplot(2,2,3);imshow(E);title('��ʴ');
% subplot(2,2,4);imshow(D);title('����');


%% ��������ղ���

I0 = imread('photo/xingtaixue1.jpg');
I = rgb2gray(I0);
SE = strel('disk',10);

E = imopen(I,SE);
D = imclose(I,SE);

subplot(1,3,1);imshow(I);title('ԭͼ');
subplot(1,3,2);imshow(E);title('������');
subplot(1,3,3);imshow(D);title('�ղ���');

%% ���л����б任
% ���л����б任��bwhitmiss(I,S1,S2)
% ͼƬ��ʾ�����⣺
% ��ν����ͼ����ԭʼ��ͬ������ʾ������

I = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 1 1 0 0 0 0 0 0 1 1 1 0 0;
    0 0 0 0 0 0 0 0 0 0 1 1 1 0 0;
    0 0 1 1 1 1 1 0 0 0 0 1 1 0 0;
    0 0 1 1 1 1 1 0 0 0 0 0 0 0 0;
    0 0 1 1 1 1 1 0 0 0 1 1 1 0 0;
    0 0 1 1 1 1 1 0 0 0 1 1 1 0 0;
    0 0 1 1 1 1 1 0 1 1 1 1 1 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

S1 = [0 1 0;1 1 1;0 1 0];
S2 = [1 1 1 1 1 1 1;
    1 0 0 0 0 0 1;
    1 0 0 0 0 0 1;
    1 0 0 0 0 0 1;
    1 0 0 0 0 0 1;
    1 0 0 0 0 0 1;
    1 1 1 1 1 1 1];

Ihm = bwhitmiss(I,S1,S2);
figure;imshow(I,'InitialMagnification','fit');title('ԭͼ');
figure;imshow(S1,'InitialMagnification','fit');title('���нṹԪ');
figure;imshow(S2,'InitialMagnification','fit');title('�����нṹԪ');
figure;imshow(Ihm,'InitialMagnification','fit');title('���л����б任');

%% �߽���ȡ�����

% 1 �߽���ȡ��
%  ɾ�����е��ڲ��㣨8�����Ǻڵ㣩
%  �ȼ���3*3�ṹԪ��ʴ�����

I = imread('photo/hough6.tif');
figure, imshow(I);
se = strel('square', 3); 
Ie = imerode(I, se);
Iout = I - Ie;
figure, imshow(Iout);

% 2 �߽����

%% �������
%  ����Ϊ�߽���ȡ�ķ�����
%  4��ͨ�ı߽磬��Χ�ɵ��ڲ�������8��ͨ��
%  8��ͨ�ı߽�Χ�ɵ��ڲ�����ȴ��4��ͨ��

%% ��ͨ��������ȡ��Ӧ��
%  [L num] = bwlabel (Ibw, conn)

I0 = imread('photo/hough6.tif');
SE = strel('disk',6);
I = imerode(I0,SE);
figure, imshow(I);
[L, num] = bwlabel(I);


%% ϸ���㷨

%% ���ػ��㷨

%% ͹�Ǽ�ʵ��

%% ������̬ѧ������bwmorph(I, operation, n)
%  n����������
%  operation:
% 'bridge' �Ž��ɵ������ط�϶�ָ���ǰ������
% 'clean'  ���������ǰ������
% 'diag'   Χ�ƶԽ���������ǰ�����ؽ������
% 'fill'   ��䵥�����صĿ׶�
% 'hbreak' ȥ̯ǰ���е�H������
% 'majority' ���P��8������һ�����ϵ�����Ϊǰ�������� ��ʹPҲΪǰ�����ط���ʹPΪ��������
% 'remove' ȥ���ڲ����أ��ޱ����������ڵ�ǰ�����ء�
% 'shrink' ����������Ϊһ������ߴ����Ļ���
% 'skel' ���ϻ�ͼ��
% 'Spur' ȥ����ë�̡�
% 'thicken' �ֻ�����
% 'thin' ������ϸ��������޶�����������

%% �Ҷ�ͼ��Ļ�����̬ѧ�㷨
%% �Ҷ����͸�ʴ

% ���߶Ա�
I = imread ('photo/lena.jpg');
seHeight = strel(ones (3, 3), ones (3, 3));% 3*3�����ε�λ�߶ȵĽṹԪ��

Idil = imdilate(I, seHeight);
Iero = imerode(I, seHeight);
subplot(1, 3, 1), imshow(I); 
subplot(1, 3, 2), imshow(Idil);
subplot(1, 3, 3), imshow(Iero);

% f = [0 1 2 3 4 5 4 3 2 1 0];
% figure, h_f = plot(f);
% seFlat = strel([1 1 1]); %����ƽ̹(�߶�ΪO���ĽṹԪ��
% 
% % �Ҷ�����
% % fd1 = imdilate(f, seFlat);%ʹ��ƽ̹�ĽṹԪ�ػҶ�����
% % hold on, h_fd1 = plot(fd1, 'ro-');
% % axis([1 11 0 8]);
% 
% % �Ҷȸ�ʴ
% fd1 = imerode(f, seFlat);%ʹ��ƽ̹�ĽṹԪ�ػҶ�����
% hold on, h_fd1 = plot(fd1, 'ro-');
% axis([1 11 0 8]);
% 
% seHeight = strel([1 1 1], [1 1 1]);%ע��˴�strel���÷��� ��һ��������Ԫ��Ϊ0��1,
% %��ʾ�ṹԪ�ص�����Χ����״���� �ڶ���������ʾ�ṹԪ���и���Ԫ�صĸ߶�
% 
% % �Ҷ�����
% % fd2 = imdilate(f, seHeight);%ʹ�þ��и߶ȵĽṹԪ�صĻ�Ƥ����
% % hold on, h_fd2 = plot(fd2, 'g*-');
% % legend('ԭ��Ƥ1ά����f', 'ʹ��ƽ̹�ṹԪ�����ͺ�', 'ʹ�ø߶�Ϊ1�ĽṹԪ�����ͺ�');
% 
% % �Ҷȸ�ʴ
% fd2 = imerode(f, seHeight);%ʹ�þ��и߶ȵĽṹԪ�صĻ�Ƥ����
% hold on, h_fd2 = plot(fd2, 'g*-');
% legend('ԭ��Ƥ1ά����f', 'ʹ��ƽ̹�ṹԪ�����ͺ�', 'ʹ�ø߶�Ϊ1�ĽṹԪ�����ͺ�');

%% �Ҷȿ�������

% ���߶Ա�,����������Ч��
% I = imread ('photo/lena.jpg');
% seHeight = strel(ones (3, 3), ones (3, 3));% 3*3�����ε�λ�߶ȵĽṹԪ��
% 
% Idil = imopen(I, seHeight);
% Iero = imclose(I, seHeight);
% subplot(1, 3, 1), imshow(I); 
% subplot(1, 3, 2), imshow(Idil);
% subplot(1, 3, 3), imshow(Iero);

% ������
f = [0 1 2 3 4 5 4 3 2 1 0];
figure, h_f = plot(f);
seFlat = strel([1 1 1]); %����ƽ̹(�߶�ΪO���ĽṹԪ��

% �Ҷȱղ���
% fd1 = imclose(f, seFlat);%ʹ��ƽ̹�ĽṹԪ�ػҶ�����
% hold on, h_fd1 = plot(fd1, 'ro-');
% axis([1 11 0 8]);

% �Ҷȿ�����
fd1 = imopen(f, seFlat);%ʹ��ƽ̹�ĽṹԪ�ػҶ�����
hold on, h_fd1 = plot(fd1, 'ro-');
axis([1 11 0 8]);

seHeight = strel([1 1 1], [1 1 1]);%ע��˴�strel���÷��� ��һ��������Ԫ��Ϊ0��1,
%��ʾ�ṹԪ�ص�����Χ����״���� �ڶ���������ʾ�ṹԪ���и���Ԫ�صĸ߶�

% �Ҷȱղ���
% fd2 = imclose(f, seHeight);%ʹ�þ��и߶ȵĽṹԪ�صĻ�Ƥ����
% hold on, h_fd2 = plot(fd2, 'g*-');
% legend('ԭ��Ƥ1ά����f', 'ʹ��ƽ̹�ṹԪ�����ͺ�', 'ʹ�ø߶�Ϊ1�ĽṹԪ�����ͺ�');

% �Ҷȿ�����
fd2 = imopen(f, seHeight);%ʹ�þ��и߶ȵĽṹԪ�صĻ�Ƥ����
hold on, h_fd2 = plot(fd2, 'g*-');
legend('ԭ��Ƥ1ά����f', 'ʹ��ƽ̹�ṹԪ�����ͺ�', 'ʹ�ø߶�Ϊ1�ĽṹԪ�����ͺ�');


%% ��ñ�任
% ������ղ��������

I = imread ('rice.png');

thresh = graythresh(I);
Ibw = im2bw(I, thresh);

seHeight = strel('disk',15);% 3*3�����ε�λ�߶ȵĽṹԪ��

Idil = imopen(I, seHeight);
Itophat = imsubtract(I,Idil);

Iadj = imadjust(Itophat);
thresh_adj = graythresh(Iadj);
Ibw_adj = im2bw(Iadj, thresh);

subplot(2, 3, 1), imshow(I);title('ԭͼ');
subplot(2, 3, 4), imshow(Ibw); title('ԭͼ��ֵ��');
subplot(2, 3, 2), imshow(Idil);title('������');
subplot(2, 3, 5), imshow(Itophat);title('��ñ');
subplot(2, 3, 3), imshow(Iadj);title('�Աȶ�����');
subplot(2, 3, 6), imshow(Ibw_adj); title('��ͼ��ֵ�����');

%% 

I10 = sparse([2,2,2,3,3,3,4,4,4,4,4,5,5,5,6,6,6,7,7,7,8,8,8,8,8,8],...
    [2,3,4,2,4,5,2,3,5,6,7,3,4,7,2,3,7,2,4,7,2,3,4,5,6,7],...
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],9,10);
I1 = full(I10);

I20 = sparse([2,2,2,3,3,4,4,5,5,5,6,6,7,7,8,8],...
    [4,5,6,3,7,2,7,3,6,7,2,5,2,4,2,3],...
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],9,10);
I2 = full(I20);

imshow(I2,'InitialMagnification','fit');


