%�Ҷȶ����任-Ƶ��ͼ�����ʾ
%��ǿͼ��ϰ����ֵ�ϸ��
%��չ��ѹ����ֵͼ���нϰ�����

I=imread('lena.jpg');
F=fft2(im2double(I));%Ƶ��,���ľ��Ը߻Ҷ�
F=fftshift(F);
F=abs(F);
T=log(F+1);%�����任

subplot(1,2,1);
imshow(F,[]); %�վ���Ĭ�������С�Ҷȣ��Ҷ�����Ч��
title('�任ǰ');

subplot(1,2,2);
imshow(T,[]);
title('�任��');


