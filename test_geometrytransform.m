%% ͼ�񼸺α任
%��ζ����в�ɫͼ������
%������ͼ������
%��β���ʧ��Ϣ
%����Ծ�����ʽ��ʾ���б任
%% 
%Ŀǰ�㷨ֻ���ǻҶ�ͼ��
%���䣬Ӧ��matlab�Դ��㷨Ҳ���ԣ����Ա�

%% ͼ��ƽ�ƣ�myimmove

I=imread('lena.jpg');
I0=myimmove(I,[100,30]);  %�ڶ�������ʾ�ƶ���������λΪһ�����ؾ���
subplot(1,2,1);imshow(I);title('ԭͼ');
subplot(1,2,2);imshow(I0),title('ƽ��');

%imshow���⣺֮ǰ��Ҫ��256���µĺ�������Ҫ
%imshow��bug
%ע���о���

%% ͼ����&ת�ã�myimmirror 

I=imread('lena.jpg');
I1=myimmirror(I,'vertical');  
I2=myimmirror(I,'horizontal'); 
I3=myimmirror(I,'transpose');   %ת��
subplot(2,2,1);imshow(I);title('ԭͼ');
subplot(2,2,2);imshow(I1),title('��ֱ');
subplot(2,2,3);imshow(I2),title('ˮƽ');
subplot(2,2,4);imshow(I3),title('ת��');

%% ͼ������: myimresize
%  X,Y ���ű�����һ��[Sx,Sy];
%  ��ΰ�ԭʼ��С��ʾͼ�񣿣���
%  ������

I=imread('taylor9.jpg');                            
I=rgb2gray(I);                    
I1=myimresize(I,2,'nearest');                       
I2=myimresize(I,[1.2,1.3],'nearest');                
subplot(1,2,1);
%subplot('position',[.1 .1 .8 .8]);   
imshow(I);title('ԭͼ');
subplot(1,2,2);
%subplot('position',[.5 .5 .8 .8]);
imshow(I1);title('���ٽ���ֵ');

%subplot('position',[left bottom width height])
%creates an axis at the specified position in normalized coordinates
%(in the range from 0.0 to 1.0).

% I1=imresize(I,2,'nearest');                       
% I2=imresize(I,[400,400],'nearest');                
% subplot(1,3,1);imshow(I);title('ԭͼ');              
% subplot(1,3,2);imshow(I1);title('���ٽ���ֵ');      
% subplot(1,3,3);imshow(I2);title('���ٽ���ֵ');  


%% ͼ����ת myimrotate
%  ��ʱ���޻Ҷ�ͼ��
%  ��ֵĬ������ڲ�ֵ
%  ��ʱ�����ĵ���ʱ����ת
%  ����ϵԭ��Ӧƽ�Ƶ�����
%  ���ȥ����Եë��

I=imread('taylor9.jpg');                            
I=rgb2gray(I);  

%  ��д������ڲ�ֵ�߽���ͬ����ͼ���ڲ��ƺ���ģ��
B1=myimrotate(I, 30, 'linear');  %crop��ʾ�ü�
%  ��д��˫���Բ�ֵ���ڱ߽���ʮ�����ߵ�����
B2=myimrotate(I, 30, 'linear', 'crop');  %crop��ʾ�ü�

C1 = imrotate(I,30,'bilinear') ;
C2 = imrotate(I,30,'bilinear','crop') ;

% subplot(1,3,1);imshow(I);title('ԭͼ');              
% subplot(2,3,2);
subplot(1,2,1);imshow(B1);title('my��ת-���ü�'); 
% subplot(2,3,3);imshow(B2);title('my��ת-�ü�');
% subplot(2,3,5);
subplot(1,2,2);imshow(C1);title('��ת-���ü�'); 
%subplot(2,3,6);imshow(C2);title('��ת-�ü�');

% A = imread('lena.jpg');
% B = imrotate(I,30,'nearest','crop');
% C1 = imrotate(I,30,'bilinear') ;
% C2 = imrotate(I,30,'bilinear','crop') ;
% D = imrotate(A,30,'bicubic','crop');
% 
% subplot (2,3,1),imshow(A);
% title ('ԭͼ��');
% subplot(2,3,4),imshow(B);
% title ('����ڲ�ֵ') ;
% subplot(2,3,5),
% subplot(1,2,2);imshow(B);
% title ( '˫���Բ�ֵ') ;
% subplot(2,3,6),imshow(D);
% title ('˫���β�ֵ');

%% ͼ����׼

% 1 ����ͼ��
Iin = imread('chepai1.jpg');Iin=rgb2gray(Iin);
Ibase = imread('chepai2.jpg');Ibase=rgb2gray(Ibase);
figure
subplot(1,2,1),imshow(Iin);
subplot(1,2,2),imshow(Ibase);

% 2 ��ע��׼�㣬�����䱣���������ռ�,�ֱ����ɶԲ���
cpselect(Iin,Ibase);

% 3 ָ��Ҫʹ�õı任����
tform = fitgeotrans(movingPoints, fixedPoints, 'projective'); %����任ģ��
% ֮ǰcp2tform
%TRANSFORMATIONTYPE can be 
%'nonreflectivesimilarity', 'similarity','affine', or 'projective'.

% 4 ���ݱ任�ṹ������ͼ����б任����ɻ�׼��Ķ�׼
Iout = imwarp (Iin, tform);   %֮ǰ�õ�imtransform
% ��֤�����С��������ͬ
%B = IMTRANSFORM(A,T,'XYScale',1) 
figure
subplot(1, 2, 1), imshow(Iout);
subplot(1, 2, 2), imshow(Ibase);


%% ʵ�������Ƽ���У��
% ���ͨ��matlabУ������ȡ���ƴ�С
% ����У���Լ�ʶ���������ģ�����߲�������ͼƬ

Iin=imread('chepai12.jpg');
imshow(Iin);







% ƽ���˲�
% h=fspecial('average', 5 );  %3*3ƽ��ģ��
% I3=imfilter(Iin, h, 'corr', 'replicate') ; %����˲��� �ظ����߽�
% figure
% imshow(I3)










