%�Ҷ���ֵ�任�����Ҷ�ͼ��ת��Ϊ��ֵͼ��
I=imread('������.jpg');
thresh=graythresh(I);%����Ӧȷ����ֵ,���138

bw1=im2bw(I,thresh);%��ֵ��

bw2=im2bw(I,65/255);%��130Ϊ��ֵ����0��1����
%������Ϊ�μ�С��ֵ��ͼ�к�ɫ���򷴶�����
%��Ϊ0��ʾ�ڣ�����
subplot(1,3,1);imshow(I);title('ԭͼ��');
subplot(1,3,2);imshow(bw1);title('����Ӧ��ֵ');
subplot(1,3,3);imshow(bw2);title('��ֵ130');