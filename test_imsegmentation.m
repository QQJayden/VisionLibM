%% 图像分割

%% 边缘检测
%  基本步骤： 1 平滑滤波 2 锐化滤波 3 边缘判定 4 边缘连接 
%  梯度算子：BW = edge(I,type,thresh,direction，’nothinning' )
%  高斯-拉普拉斯算子：BW = edge(I,'log',thresh,sigma)
%  canny算子：BW = edge(I,'canny',thresh,sigma)

% matlab自带函数, 
% circuit.tif为matlab自带图像
intensity = imread('edge2.tif'); %读入源图像
%intensity = rgb2gray(intensity);

bw1 = edge(intensity,'sobel');
bw2 = edge(intensity,'prewitt');
bw3 = edge(intensity,'roberts');
bw4 = edge(intensity,'log');
bw5 = edge(intensity,'canny');

% subplot(2,3,1);
imshow(intensity); title('原图');
% subplot(2,3,2); 
figure
imshow(bw1); title('sobel'); 
% subplot(2,3,3); 
figure
imshow(bw2); title('prewitt'); 
% subplot(2,3,4); 
figure
imshow(bw3); title('roberts'); 
% subplot(2,3,5); 
figure
imshow(bw4); title('log'); 
% subplot(2,3,6); 
figure
imshow(bw5); title('canny'); 

%% 霍夫变换-MATLAB-直线检测
%  之后自写函数
%  检测间断点边界形状

%  hough变换直线检测：
% 1 霍夫矩阵：[H, theta, rho) = hough(BW,param1,val1,param2,val2)
% 2 寻找峰值：peaks=houghpeaks(H,numpeaks, param1,val1,param2,val2)
% 3 提取直线段：lines = houghlines(BW,theta, rho, peaks, paraml, vall, param2, val2)
%  circuit.tif 旋转30度作为检测图像

% I = imread('circuit.tif');
% 
% %旋转图像并寻找边缘
% rotI = imrotate(I, 33,'crop');
% BW = edge(rotI,'canny');

rotI = imread('photo/hough5.png');
rotI = rgb2gray(rotI);
BW = rotI;
%BW = edge(rotI,'canny');
imshow(BW);

%执行Hough变换并显示Hough矩阵
[H,T,R] = hough(BW);
figure,imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel ('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

%在Hough矩阵中寻找前5个大于Hough矩阵中最大值0.3倍的峰值
P = houghpeaks(H,5,'threshold', ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1)); %由行、列索引转换成实际坐标
plot(x,y,'s','color', 'red'); %在Hough矩阵图像中标出峰值位置

%找到并绘制直线(结构体)
lines = houghlines(BW,T,R,P,'FillGap',5, 'MinLength', 7);
%合并距离小于5的钱段， 丢弃所有长度小于7的直线段
figure, imshow(rotI), hold on

max_len = 0;
for k = 1:length(lines)   %依次标出各条直线段
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:, 1) , xy(:, 2),'LineWidth',2,'Color','green');
    
    %绘制线段端点
    plot(xy(1, 1) ,xy(1, 2), 'x', 'LineWidth',2, 'Color','yellow');
    plot(xy(2,1),xy(2,2),'x', 'LineWidth', 2, 'Color', 'red');

    %确定最长的线段:  norm表示矩阵范数
    len = norm(lines(k).point1 - lines (k) .point2);
    if (len > max_len)
        max_len = len;
        xy_long = xy;
    end
end

%高亮显示最长线段
plot(xy_long(:,1),xy_long(:, 2),'LineWidth',2, 'Color','cyan'); 

%曲线检测
%任意形状检测

%% 霍夫变换-自写函数-直线检测-myhough_lines-ghough

rotI = imread('photo/hough5.png');
rotI = rgb2gray(rotI);
BW = rotI;
%BW = edge(rotI,'canny');
imshow(BW);

%执行Hough变换并显示Hough矩阵
[H1,T,R] = myhough_lines(BW);
figure,imshow(H1,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel ('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

%在Hough矩阵中寻找前5个大于Hough矩阵中最大值0.3倍的峰值
P = houghpeaks(H1,5,'threshold', ceil(0.1*max(H1(:))));
x = T(P(:,2)); y = R(P(:,1)); %由行、列索引转换成实际坐标
plot(x,y,'s','color', 'red'); %在Hough矩阵图像中标出峰值位置

%找到并绘制直线(结构体)
lines = houghlines(BW,T,R,P,'FillGap',5, 'MinLength', 7);
%合并距离小于5的钱段， 丢弃所有长度小于7的直线段
figure, imshow(rotI), hold on

max_len = 0;
for k = 1:length(lines)   %依次标出各条直线段
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:, 1) , xy(:, 2),'LineWidth',2,'Color','green');
    
    %绘制线段端点
    plot(xy(1, 1) ,xy(1, 2), 'x', 'LineWidth',2, 'Color','yellow');
    plot(xy(2,1),xy(2,2),'x', 'LineWidth', 2, 'Color', 'red');

    %确定最长的线段:  norm表示矩阵范数
    len = norm(lines(k).point1 - lines (k) .point2);
    if (len > max_len)
        max_len = len;
        xy_long = xy;
    end
end

%高亮显示最长线段
plot(xy_long(:,1),xy_long(:, 2),'LineWidth',2, 'Color','cyan');




%% 霍夫变换-自写函数-圆与椭圆检测-myhough_circle
%  霍夫变换直线检测
%  霍夫变换检测圆与椭圆
%  myhough(BW,shape,param1,val1,param2,val2)

%?Hough变换
%?将图像空间(x,y)对应到参数空间(a,b,r)?
%?a?=?x-r*cos(angle)?
%?b?=?y-r*sin(angle)


% p:阈值，0，1之间的数
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% output  
% hough_space:参数空间，h(a,b,r)表示圆心在(a,b)半径为r的圆上的点数 
% hough_circl:二值图像，检测到的圆
% para:检测到的圆的圆心、半径
 
rotI = imread('photo/hough5.png');
rotI = rgb2gray(rotI);
BW = rotI;

[m,n] = size(BW);  
r_max = min(m/2, n/2);
r_min = 1;
step_r = 1;
step_angle = 1;

size_r = round((r_max-r_min)/step_r)+1; 
size_angle = round(2*pi/step_angle); 
hough_space = zeros(m,n,size_r); 
[rows,cols] = find(BW); 
ecount = size(rows); 

% Hough变换  
% 将图像空间(x,y)对应到参数空间(a,b,r)
% a = x-r*cos(angle) 
% b = y-r*sin(angle) 
for i=1:ecount 
    for r=1:size_r  
        for k=1:size_angle 
            a = round(rows(i)-(r_min+(r-1)*step_r)*cos(k*step_angle)); 
            b = round(cols(i)-(r_min+(r-1)*step_r)*sin(k*step_angle)); 
            if(a>0&&a<=m&&b>0&&b<=n) 
                hough_space(a,b,r) = hough_space(a,b,r)+1;             
            end
        end
    end
end

% 搜索超过阈值的聚集点 
p = 0.3;
max_para = max(max(max(hough_space))); 
index = find(hough_space>=max_para*p); 
length = size(index); 
hough_circle = false(m,n); 

for i=1:ecount     
    for k=1:length 
        par3 = floor(index(k)/(m*n))+1; 
        par2 = floor((index(k)-(par3-1)*(m*n))/m)+1;        
        par1 = index(k)-(par3-1)*(m*n)-(par2-1)*m; 
        if((rows(i)-par1)^2+(cols(i)-par2)^2<(r_min+(par3-1)*step_r)^2+5&... 
                (rows(i)-par1)^2+(cols(i)-par2)^2>(r_min+(par3-1)*step_r)^2-5) 
            rotI = imread('photo/hough5.png');
rotI = rgb2gray(rotI);
BW = rotI;hough_circle(rows(i),cols(i)) = true;         
        end
    end
end  

% 打印检测结果
for k=1:length  
    par3 = floor(index(k)/(m*n))+1;  
    par2 = floor((index(k)-(par3-1)*(m*n))/m)+1; 
    par1 = index(k)-(par3-1)*(m*n)-(par2-1)*m; 
    par3 = r_min+(par3-1)*step_r;  
    fprintf(1,'Center %d %d radius %d\n',par1,par2,par3); 
    para(:,k) = [par1,par2,par3]; 
end
  

%% 阈值分割
%  多阈值的情况如何处理
%  mygraythresh  返回阈值0-1之间

%  自写函数，涵盖以上三种方法 mygraythresh
I = imread('rice.png');
%I = imread('coins.png');
imshow(I);

%  最大类间方差法 Ostu：(myostu从网上抄的)

thresh1 = graythresh(I);
BW = im2bw(I, thresh1);
thresh2 = mygraythresh(I,'ostu');
BW2 = im2bw(I, thresh2);

figure
subplot(1,2,1);imshow(BW);title('matlab');
subplot(1,2,2);imshow(BW2);title('mygraythresh');

%  迭代选择阈值法 Iteration：
thresh3 = mygraythresh(I,'iteration');
BW3 = im2bw(I, thresh3);
figure 
imshow(BW3);

%  最小均方误差法 Mmse:???
%  建议查查论文，原理不是很详细

%  局部阈值处理：？？？
%  效果不错
%  1 顶帽算子
%  2 graythresh
se = strel('disk',10);
Itop =imtophat(I, se);   %顶帽变换
thresh4 = graythresh(Itop);
BW4 = im2bw(Itop,thresh4);
figure
subplot(1,2,1);imshow(Itop);title('顶帽变换');
subplot(1,2,2);imshow(BW4);title('局部阈值');

%% 区域分割
%% 区域生长与区域分裂合并
%% 区域生长
%  regiongrow 基于灰度平均值差值
%  只能选择一个点，应将其改善——myregionGrow

% getpts: 可以用鼠标选择坐标点
% myregiongrow( input_image, growCriterion, threshhold )
%   growCriterion: 生长规则类型
%         grayDifference: 基于灰度差
%         kolmogorovSmirnov: 基于区域内灰度统计1
%         smoothedDifference：基于区域内灰度统计2
%         shape1： 基于区域形状1
%         shape2： 基于区域形状2
%  如何自适应确定阈值


Iin = imread('coins.png');
%imshow(Iin);title('原图');
Iout = myregiongrow(Iin, 'grayDifference', 0.05 );
Iout0 = regionGrow(Iin,0.20);

figure
subplot(1,2,1);imshow(Iout0);title('平均灰度差');
subplot(1,2,2);imshow(Iout);title('中心灰度差');


%% 区域分裂合并-MATLAB
%  相关的3个主要函数分别是qtdecomp, qtgetblk和qtsetblk.
%  qtdecomp： 可以进行囚叉树分解。该函数首先将图像划分成相等大小的4块，
%             然后对每一个块进行一致性检查。
%  qtgetblk： 可进一步获得四叉树分解后所有指定大小的子块像素及位置信息
%  qtsetblk： 将四叉树分解所得到的子块中符合条件的部分全部替换为指定的子块


I1 = imread('rice.png');  %读入原因像
imshow(I1)  

%选取阈值0.2， 对原始图像进行四叉树分解,得到稀疏矩阵
S = qtdecomp(I1,0.2);

%原始的稀疏矩阵转换为普通矩阵，使用full函数
S2 = full(S);
figure;
imshow(S2);

ct = zeros(6, 1); %记录子块数目的列向量
vals{ii}=[];

%分别获得不同大小块的信息，子块内容保存在三维数组valsl ～val6中，子块数目保存在ct向量中
for ii = 1:6
    [vals{ii} ,r,c] = qtgetblk(I1,S2, 2^(ii-1));
    ct(ii) = size(vals{ii},3);
end

%% 区域分裂合并-自写函数
rotI = imread('photo/hough5.png');
rotI = rgb2gray(rotI);
BW = rotI;
I = im2double(BW);

[M, N] = size(I);

theta = -89:90;
ntheta = length(theta);
rho_max = ceil(sqrt(M^2 + N^2));
rho = 0:rho_max;
nrho = length(rho);

h = zeros(nrho, ntheta);

for i = 1:M
    for j = 1:N
            for t=-89:90
                theta_rad = t*pi/180;
                nrho_new = round(abs(i*cos(theta_rad)+j*sin(theta_rad)))+1;
                ntheta_new = t + 90;
                h(nrho_new, ntheta_new) = h(nrho_new, ntheta_new) + 1;   
            end
    end
end

