%% 图像几何变换
%如何对所有彩色图像适用
%对索引图像适用
%如何不丢失信息
%如何以矩阵形式表示所有变换
%% 
%目前算法只考虑灰度图像
%补充，应将matlab自带算法也试试，并对比

%% 图像平移：myimmove

I=imread('lena.jpg');
I0=myimmove(I,[100,30]);  %第二个量表示移动向量，单位为一个像素距离
subplot(1,2,1);imshow(I);title('原图');
subplot(1,2,2);imshow(I0),title('平移');

%imshow问题：之前需要除256，新的函数则不需要
%imshow的bug
%注意有警告

%% 图像镜像&转置：myimmirror 

I=imread('lena.jpg');
I1=myimmirror(I,'vertical');  
I2=myimmirror(I,'horizontal'); 
I3=myimmirror(I,'transpose');   %转置
subplot(2,2,1);imshow(I);title('原图');
subplot(2,2,2);imshow(I1),title('竖直');
subplot(2,2,3);imshow(I2),title('水平');
subplot(2,2,4);imshow(I3),title('转置');

%% 图像缩放: myimresize
%  X,Y 缩放比例不一致[Sx,Sy];
%  如何按原始大小显示图像？？？
%  待改正

I=imread('taylor9.jpg');                            
I=rgb2gray(I);                    
I1=myimresize(I,2,'nearest');                       
I2=myimresize(I,[1.2,1.3],'nearest');                
subplot(1,2,1);
%subplot('position',[.1 .1 .8 .8]);   
imshow(I);title('原图');
subplot(1,2,2);
%subplot('position',[.5 .5 .8 .8]);
imshow(I1);title('最临近插值');

%subplot('position',[left bottom width height])
%creates an axis at the specified position in normalized coordinates
%(in the range from 0.0 to 1.0).

% I1=imresize(I,2,'nearest');                       
% I2=imresize(I,[400,400],'nearest');                
% subplot(1,3,1);imshow(I);title('原图');              
% subplot(1,3,2);imshow(I1);title('最临近插值');      
% subplot(1,3,3);imshow(I2);title('最临近插值');  


%% 图像旋转 myimrotate
%  暂时仅限灰度图像
%  插值默认最近邻插值
%  暂时绕中心点逆时针旋转
%  坐标系原点应平移到中心
%  如何去除边缘毛刺

I=imread('taylor9.jpg');                            
I=rgb2gray(I);  

%  自写的最近邻插值边界相同，但图像内部似乎更模糊
B1=myimrotate(I, 30, 'linear');  %crop表示裁剪
%  自写的双线性插值存在边界与十字虚线等问题
B2=myimrotate(I, 30, 'linear', 'crop');  %crop表示裁剪

C1 = imrotate(I,30,'bilinear') ;
C2 = imrotate(I,30,'bilinear','crop') ;

% subplot(1,3,1);imshow(I);title('原图');              
% subplot(2,3,2);
subplot(1,2,1);imshow(B1);title('my旋转-不裁剪'); 
% subplot(2,3,3);imshow(B2);title('my旋转-裁剪');
% subplot(2,3,5);
subplot(1,2,2);imshow(C1);title('旋转-不裁剪'); 
%subplot(2,3,6);imshow(C2);title('旋转-裁剪');

% A = imread('lena.jpg');
% B = imrotate(I,30,'nearest','crop');
% C1 = imrotate(I,30,'bilinear') ;
% C2 = imrotate(I,30,'bilinear','crop') ;
% D = imrotate(A,30,'bicubic','crop');
% 
% subplot (2,3,1),imshow(A);
% title ('原图像');
% subplot(2,3,4),imshow(B);
% title ('最近邻插值') ;
% subplot(2,3,5),
% subplot(1,2,2);imshow(B);
% title ( '双线性插值') ;
% subplot(2,3,6),imshow(D);
% title ('双三次插值');

%% 图像配准

% 1 读入图像
Iin = imread('chepai1.jpg');Iin=rgb2gray(Iin);
Ibase = imread('chepai2.jpg');Ibase=rgb2gray(Ibase);
figure
subplot(1,2,1),imshow(Iin);
subplot(1,2,2),imshow(Ibase);

% 2 标注基准点，并将其保存至工作空间,分别点击成对部分
cpselect(Iin,Ibase);

% 3 指定要使用的变换类型
tform = fitgeotrans(movingPoints, fixedPoints, 'projective'); %放射变换模型
% 之前cp2tform
%TRANSFORMATIONTYPE can be 
%'nonreflectivesimilarity', 'similarity','affine', or 'projective'.

% 4 根据变换结构对输入图像进行变换，完成基准点的对准
Iout = imwarp (Iin, tform);   %之前用的imtransform
% 保证输出大小与输入相同
%B = IMTRANSFORM(A,T,'XYScale',1) 
figure
subplot(1, 2, 1), imshow(Iout);
subplot(1, 2, 2), imshow(Ibase);


%% 实例：车牌几何校正
% 如何通过matlab校正，提取车牌大小
% 车牌校正以及识别可能遇到模糊或者不清晰的图片

Iin=imread('chepai12.jpg');
imshow(Iin);







% 平滑滤波
% h=fspecial('average', 5 );  %3*3平均模饭
% I3=imfilter(Iin, h, 'corr', 'replicate') ; %相关滤波， 重复填充边界
% figure
% imshow(I3)










