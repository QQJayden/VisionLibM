%gamma�任
%gamma>1: �߻Ҷ�����Աȶ���ǿ
%gamma=1�� ���Բ��ñ�ͼ��
%gamma<1: �ͻҶ�����Աȶ���ǿ
I=imread('lena.jpg');
%gamma=0.75
subplot(1,3,1);
imshow(imadjust(I,[],[],0.75));  %[][]Ĭ��0-1
title('gamma=0.75');
%gamma=1
subplot(1,3,2);
imshow(imadjust(I,[],[],1));
title('gamma=1');
%gamma=1.5
subplot(1,3,3);
imshow(imadjust(I,[],[],1.5));
title('gamma=1.5');