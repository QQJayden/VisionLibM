%% 形态学图像处理
% 腐蚀：imerode(I,SE)
% 膨胀：imdilate(I,SE)
% 开运算：imopen(I,SE)
% 闭运算：imclose(I,SE)
% 击中击不中变换：bwhitmiss(I,S1,S2)

% SE:
% 'arbitrary'或为空任意自定义的结构元素
% 'disk’ 圆形结构元素
% 'square' 正方形结构元素
% 'rectangle’ 矩形结构元素
% 'line’ 线形的结构元素
% 'pair' 包含2个点的结构元素
% 'diamond' 菱形的结构元素
% 'octagon' 8角形的结构元素

% 多种形态学操作：bwmorph(I, operation, n)
% imshow(I,'InitialMagnification','fit');

%% 腐蚀与膨胀

% I0 = sparse([2,3,3,3,4,4,5], [2,2,3,4,3,4,3],[1,1,1,1,1,1,1],6,6);
% I = full(I0);
% SE0 = sparse([3,3,4],[3,4,3],[1,1,1],6,6);
% SE = full(SE0);

% subplot(2,2,1);imshow(I);title('原图');
% subplot(2,2,2);imshow(SE);title('结构元');
% subplot(2,2,3);imshow(E);title('腐蚀');
% subplot(2,2,4);imshow(D);title('膨胀');


%% 开操作与闭操作

I0 = imread('photo/xingtaixue1.jpg');
I = rgb2gray(I0);
SE = strel('disk',10);

E = imopen(I,SE);
D = imclose(I,SE);

subplot(1,3,1);imshow(I);title('原图');
subplot(1,3,2);imshow(E);title('开操作');
subplot(1,3,3);imshow(D);title('闭操作');

%% 击中击不中变换
% 击中击不中变换：bwhitmiss(I,S1,S2)
% 图片显示老问题：
% 如何将多幅图像按照原始不同比例显示？？？

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
figure;imshow(I,'InitialMagnification','fit');title('原图');
figure;imshow(S1,'InitialMagnification','fit');title('击中结构元');
figure;imshow(S2,'InitialMagnification','fit');title('击不中结构元');
figure;imshow(Ihm,'InitialMagnification','fit');title('击中击不中变换');

%% 边界提取与跟踪

% 1 边界提取：
%  删除所有的内部点（8邻域都是黑点）
%  等价于3*3结构元腐蚀并求差

I = imread('photo/hough6.tif');
figure, imshow(I);
se = strel('square', 3); 
Ie = imerode(I, se);
Iout = I - Ie;
figure, imshow(Iout);

% 2 边界跟踪

%% 区域填充
%  可视为边界提取的反过程
%  4连通的边界，其围成的内部区域是8连通的
%  8连通的边界围成的内部区域却是4连通的

%% 连通分量的提取与应用
%  [L num] = bwlabel (Ibw, conn)

I0 = imread('photo/hough6.tif');
SE = strel('disk',6);
I = imerode(I0,SE);
figure, imshow(I);
[L, num] = bwlabel(I);


%% 细化算法

%% 像素化算法

%% 凸壳及实现

%% 多种形态学操作：bwmorph(I, operation, n)
%  n：操作次数
%  operation:
% 'bridge' 桥接由单个像素缝隙分隔的前景像素
% 'clean'  清除孤立的前景像索
% 'diag'   围绕对角线相连的前景像素进行填充
% 'fill'   填充单个像素的孔洞
% 'hbreak' 去摊前景中的H形连接
% 'majority' 如点P的8邻域中一半以上的像素为前景像索， 则使P也为前景像素否则使P为背景像萦
% 'remove' 去处内部像素（无背景像素相邻的前景像素〉
% 'shrink' 将物体收缩为一个点或者带洞的环形
% 'skel' 骨锵化图像
% 'Spur' 去除“毛刺”
% 'thicken' 粗化物体
% 'thin' 将物体细化至最低限度相连的线形

%% 灰度图像的基本形态学算法
%% 灰度膨胀腐蚀

% 两者对比
I = imread ('photo/lena.jpg');
seHeight = strel(ones (3, 3), ones (3, 3));% 3*3正方形单位高度的结构元素

Idil = imdilate(I, seHeight);
Iero = imerode(I, seHeight);
subplot(1, 3, 1), imshow(I); 
subplot(1, 3, 2), imshow(Idil);
subplot(1, 3, 3), imshow(Iero);

% f = [0 1 2 3 4 5 4 3 2 1 0];
% figure, h_f = plot(f);
% seFlat = strel([1 1 1]); %构造平坦(高度为O）的结构元素
% 
% % 灰度膨胀
% % fd1 = imdilate(f, seFlat);%使用平坦的结构元素灰度膨胀
% % hold on, h_fd1 = plot(fd1, 'ro-');
% % axis([1 11 0 8]);
% 
% % 灰度腐蚀
% fd1 = imerode(f, seFlat);%使用平坦的结构元素灰度膨胀
% hold on, h_fd1 = plot(fd1, 'ro-');
% axis([1 11 0 8]);
% 
% seHeight = strel([1 1 1], [1 1 1]);%注意此处strel的用法， 第一个参数的元素为0或1,
% %表示结构元素的区域范围（形状〉， 第二个参数表示结构元囊中各个元素的高度
% 
% % 灰度膨胀
% % fd2 = imdilate(f, seHeight);%使用具有高度的结构元素的灰皮膨胀
% % hold on, h_fd2 = plot(fd2, 'g*-');
% % legend('原灰皮1维函数f', '使用平坦结构元素膨胀后', '使用高度为1的结构元素膨胀后');
% 
% % 灰度腐蚀
% fd2 = imerode(f, seHeight);%使用具有高度的结构元素的灰皮膨胀
% hold on, h_fd2 = plot(fd2, 'g*-');
% legend('原灰皮1维函数f', '使用平坦结构元素膨胀后', '使用高度为1的结构元素膨胀后');

%% 灰度开闭运算

% 两者对比,看不出明显效果
% I = imread ('photo/lena.jpg');
% seHeight = strel(ones (3, 3), ones (3, 3));% 3*3正方形单位高度的结构元素
% 
% Idil = imopen(I, seHeight);
% Iero = imclose(I, seHeight);
% subplot(1, 3, 1), imshow(I); 
% subplot(1, 3, 2), imshow(Idil);
% subplot(1, 3, 3), imshow(Iero);

% ！！！
f = [0 1 2 3 4 5 4 3 2 1 0];
figure, h_f = plot(f);
seFlat = strel([1 1 1]); %构造平坦(高度为O）的结构元素

% 灰度闭操作
% fd1 = imclose(f, seFlat);%使用平坦的结构元素灰度膨胀
% hold on, h_fd1 = plot(fd1, 'ro-');
% axis([1 11 0 8]);

% 灰度开操作
fd1 = imopen(f, seFlat);%使用平坦的结构元素灰度膨胀
hold on, h_fd1 = plot(fd1, 'ro-');
axis([1 11 0 8]);

seHeight = strel([1 1 1], [1 1 1]);%注意此处strel的用法， 第一个参数的元素为0或1,
%表示结构元素的区域范围（形状〉， 第二个参数表示结构元囊中各个元素的高度

% 灰度闭操作
% fd2 = imclose(f, seHeight);%使用具有高度的结构元素的灰皮膨胀
% hold on, h_fd2 = plot(fd2, 'g*-');
% legend('原灰皮1维函数f', '使用平坦结构元素膨胀后', '使用高度为1的结构元素膨胀后');

% 灰度开操作
fd2 = imopen(f, seHeight);%使用具有高度的结构元素的灰皮膨胀
hold on, h_fd2 = plot(fd2, 'g*-');
legend('原灰皮1维函数f', '使用平坦结构元素膨胀后', '使用高度为1的结构元素膨胀后');


%% 顶帽变换
% 处理光照不均的情况

I = imread ('rice.png');

thresh = graythresh(I);
Ibw = im2bw(I, thresh);

seHeight = strel('disk',15);% 3*3正方形单位高度的结构元素

Idil = imopen(I, seHeight);
Itophat = imsubtract(I,Idil);

Iadj = imadjust(Itophat);
thresh_adj = graythresh(Iadj);
Ibw_adj = im2bw(Iadj, thresh);

subplot(2, 3, 1), imshow(I);title('原图');
subplot(2, 3, 4), imshow(Ibw); title('原图二值化');
subplot(2, 3, 2), imshow(Idil);title('开操作');
subplot(2, 3, 5), imshow(Itophat);title('顶帽');
subplot(2, 3, 3), imshow(Iadj);title('对比度拉伸');
subplot(2, 3, 6), imshow(Ibw_adj); title('新图二值化结果');

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


