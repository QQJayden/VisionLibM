%�ֶ����Ա任-TEST
%���ƻ�����ĳ������[x1 x2]  [y1 y2]
I=imread('lena.jpg');
J1=imgrayscaling(I,[0.3 0.7],[0.15 0.85]);
figure,imshow(J1,[]);
J2=imgrayscaling(I,[0.15 0.85],[0.3 0.7]);
figure,imshow(J2,[]);