%��ζ����в�ɫͼ������
%������ͼ������
%��β���ʧ��Ϣ
%����Ծ�����ʽ��ʾ���б任
%% 
%Ŀǰ�㷨ֻ���ǻҶ�ͼ��
%% 

% %ͼ��ƽ�ƣ�myimmove
% I=imread('lena.jpg');
% I0=myimmove(I,[100,30]);  %�ڶ�������ʾ�ƶ���������λΪһ�����ؾ���
% subplot(1,2,1);imshow(I);title('ԭͼ');
% subplot(1,2,2);imshow(I0),title('ƽ��');
% %imshow���⣺֮ǰ��Ҫ��256���µĺ�������Ҫ
% %imshow��bug

%ͼ����&ת�ã�myimmirror
I=imread('lena.jpg');
I1=myimmirror(I,'vertical');  
I2=myimmirror(I,'horizontal'); 
I3=myimmirror(I,'transpose');   %ת��
subplot(2,2,1);imshow(I);title('ԭͼ');
subplot(2,2,2);imshow(I1),title('��ֱ');
subplot(2,2,3);imshow(I2),title('ˮƽ');
subplot(2,2,4);imshow(I3),title('����');

%ͼ������

