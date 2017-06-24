%% ͼ��ָ�

%% ��Ե���
%  �������裺 1 ƽ���˲� 2 ���˲� 3 ��Ե�ж� 4 ��Ե���� 
%  �ݶ����ӣ�BW = edge(I,type,thresh,direction����nothinning' )
%  ��˹-������˹���ӣ�BW = edge(I,'log',thresh,sigma)
%  canny���ӣ�BW = edge(I,'canny',thresh,sigma)

% matlab�Դ�����, 
% circuit.tifΪmatlab�Դ�ͼ��
intensity = imread('edge2.tif'); %����Դͼ��
%intensity = rgb2gray(intensity);

bw1 = edge(intensity,'sobel');
bw2 = edge(intensity,'prewitt');
bw3 = edge(intensity,'roberts');
bw4 = edge(intensity,'log');
bw5 = edge(intensity,'canny');

% subplot(2,3,1);
imshow(intensity); title('ԭͼ');
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

%% ����任-MATLAB-ֱ�߼��
%  ֮����д����
%  ����ϵ�߽���״

%  hough�任ֱ�߼�⣺
% 1 �������[H, theta, rho) = hough(BW,param1,val1,param2,val2)
% 2 Ѱ�ҷ�ֵ��peaks=houghpeaks(H,numpeaks, param1,val1,param2,val2)
% 3 ��ȡֱ�߶Σ�lines = houghlines(BW,theta, rho, peaks, paraml, vall, param2, val2)
%  circuit.tif ��ת30����Ϊ���ͼ��

% I = imread('circuit.tif');
% 
% %��תͼ��Ѱ�ұ�Ե
% rotI = imrotate(I, 33,'crop');
% BW = edge(rotI,'canny');

rotI = imread('photo/hough5.png');
rotI = rgb2gray(rotI);
BW = rotI;
%BW = edge(rotI,'canny');
imshow(BW);

%ִ��Hough�任����ʾHough����
[H,T,R] = hough(BW);
figure,imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel ('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

%��Hough������Ѱ��ǰ5������Hough���������ֵ0.3���ķ�ֵ
P = houghpeaks(H,5,'threshold', ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1)); %���С�������ת����ʵ������
plot(x,y,'s','color', 'red'); %��Hough����ͼ���б����ֵλ��

%�ҵ�������ֱ��(�ṹ��)
lines = houghlines(BW,T,R,P,'FillGap',5, 'MinLength', 7);
%�ϲ�����С��5��Ǯ�Σ� �������г���С��7��ֱ�߶�
figure, imshow(rotI), hold on

max_len = 0;
for k = 1:length(lines)   %���α������ֱ�߶�
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:, 1) , xy(:, 2),'LineWidth',2,'Color','green');
    
    %�����߶ζ˵�
    plot(xy(1, 1) ,xy(1, 2), 'x', 'LineWidth',2, 'Color','yellow');
    plot(xy(2,1),xy(2,2),'x', 'LineWidth', 2, 'Color', 'red');

    %ȷ������߶�:  norm��ʾ������
    len = norm(lines(k).point1 - lines (k) .point2);
    if (len > max_len)
        max_len = len;
        xy_long = xy;
    end
end

%������ʾ��߶�
plot(xy_long(:,1),xy_long(:, 2),'LineWidth',2, 'Color','cyan'); 

%���߼��
%������״���

%% ����任-��д����-ֱ�߼��-myhough_lines-ghough

rotI = imread('photo/hough5.png');
rotI = rgb2gray(rotI);
BW = rotI;
%BW = edge(rotI,'canny');
imshow(BW);

%ִ��Hough�任����ʾHough����
[H1,T,R] = myhough_lines(BW);
figure,imshow(H1,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel ('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

%��Hough������Ѱ��ǰ5������Hough���������ֵ0.3���ķ�ֵ
P = houghpeaks(H1,5,'threshold', ceil(0.1*max(H1(:))));
x = T(P(:,2)); y = R(P(:,1)); %���С�������ת����ʵ������
plot(x,y,'s','color', 'red'); %��Hough����ͼ���б����ֵλ��

%�ҵ�������ֱ��(�ṹ��)
lines = houghlines(BW,T,R,P,'FillGap',5, 'MinLength', 7);
%�ϲ�����С��5��Ǯ�Σ� �������г���С��7��ֱ�߶�
figure, imshow(rotI), hold on

max_len = 0;
for k = 1:length(lines)   %���α������ֱ�߶�
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:, 1) , xy(:, 2),'LineWidth',2,'Color','green');
    
    %�����߶ζ˵�
    plot(xy(1, 1) ,xy(1, 2), 'x', 'LineWidth',2, 'Color','yellow');
    plot(xy(2,1),xy(2,2),'x', 'LineWidth', 2, 'Color', 'red');

    %ȷ������߶�:  norm��ʾ������
    len = norm(lines(k).point1 - lines (k) .point2);
    if (len > max_len)
        max_len = len;
        xy_long = xy;
    end
end

%������ʾ��߶�
plot(xy_long(:,1),xy_long(:, 2),'LineWidth',2, 'Color','cyan');




%% ����任-��д����-Բ����Բ���-myhough_circle
%  ����任ֱ�߼��
%  ����任���Բ����Բ
%  myhough(BW,shape,param1,val1,param2,val2)

%?Hough�任
%?��ͼ��ռ�(x,y)��Ӧ�������ռ�(a,b,r)?
%?a?=?x-r*cos(angle)?
%?b?=?y-r*sin(angle)


% p:��ֵ��0��1֮�����
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% output  
% hough_space:�����ռ䣬h(a,b,r)��ʾԲ����(a,b)�뾶Ϊr��Բ�ϵĵ��� 
% hough_circl:��ֵͼ�񣬼�⵽��Բ
% para:��⵽��Բ��Բ�ġ��뾶
 
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

% Hough�任  
% ��ͼ��ռ�(x,y)��Ӧ�������ռ�(a,b,r)
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

% ����������ֵ�ľۼ��� 
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

% ��ӡ�����
for k=1:length  
    par3 = floor(index(k)/(m*n))+1;  
    par2 = floor((index(k)-(par3-1)*(m*n))/m)+1; 
    par1 = index(k)-(par3-1)*(m*n)-(par2-1)*m; 
    par3 = r_min+(par3-1)*step_r;  
    fprintf(1,'Center %d %d radius %d\n',par1,par2,par3); 
    para(:,k) = [par1,par2,par3]; 
end
  

%% ��ֵ�ָ�
%  ����ֵ�������δ���
%  mygraythresh  ������ֵ0-1֮��

%  ��д�����������������ַ��� mygraythresh
I = imread('rice.png');
%I = imread('coins.png');
imshow(I);

%  �����䷽� Ostu��(myostu�����ϳ���)

thresh1 = graythresh(I);
BW = im2bw(I, thresh1);
thresh2 = mygraythresh(I,'ostu');
BW2 = im2bw(I, thresh2);

figure
subplot(1,2,1);imshow(BW);title('matlab');
subplot(1,2,2);imshow(BW2);title('mygraythresh');

%  ����ѡ����ֵ�� Iteration��
thresh3 = mygraythresh(I,'iteration');
BW3 = im2bw(I, thresh3);
figure 
imshow(BW3);

%  ��С������ Mmse:???
%  ���������ģ�ԭ���Ǻ���ϸ

%  �ֲ���ֵ����������
%  Ч������
%  1 ��ñ����
%  2 graythresh
se = strel('disk',10);
Itop =imtophat(I, se);   %��ñ�任
thresh4 = graythresh(Itop);
BW4 = im2bw(Itop,thresh4);
figure
subplot(1,2,1);imshow(Itop);title('��ñ�任');
subplot(1,2,2);imshow(BW4);title('�ֲ���ֵ');

%% ����ָ�
%% ����������������Ѻϲ�
%% ��������
%  regiongrow ���ڻҶ�ƽ��ֵ��ֵ
%  ֻ��ѡ��һ���㣬Ӧ������ơ���myregionGrow

% getpts: ���������ѡ�������
% myregiongrow( input_image, growCriterion, threshhold )
%   growCriterion: ������������
%         grayDifference: ���ڻҶȲ�
%         kolmogorovSmirnov: ���������ڻҶ�ͳ��1
%         smoothedDifference�����������ڻҶ�ͳ��2
%         shape1�� ����������״1
%         shape2�� ����������״2
%  �������Ӧȷ����ֵ


Iin = imread('coins.png');
%imshow(Iin);title('ԭͼ');
Iout = myregiongrow(Iin, 'grayDifference', 0.05 );
Iout0 = regionGrow(Iin,0.20);

figure
subplot(1,2,1);imshow(Iout0);title('ƽ���ҶȲ�');
subplot(1,2,2);imshow(Iout);title('���ĻҶȲ�');


%% ������Ѻϲ�-MATLAB
%  ��ص�3����Ҫ�����ֱ���qtdecomp, qtgetblk��qtsetblk.
%  qtdecomp�� ���Խ����������ֽ⡣�ú������Ƚ�ͼ�񻮷ֳ���ȴ�С��4�飬
%             Ȼ���ÿһ�������һ���Լ�顣
%  qtgetblk�� �ɽ�һ������Ĳ����ֽ������ָ����С���ӿ����ؼ�λ����Ϣ
%  qtsetblk�� ���Ĳ����ֽ����õ����ӿ��з��������Ĳ���ȫ���滻Ϊָ�����ӿ�


I1 = imread('rice.png');  %����ԭ����
imshow(I1)  

%ѡȡ��ֵ0.2�� ��ԭʼͼ������Ĳ����ֽ�,�õ�ϡ�����
S = qtdecomp(I1,0.2);

%ԭʼ��ϡ�����ת��Ϊ��ͨ����ʹ��full����
S2 = full(S);
figure;
imshow(S2);

ct = zeros(6, 1); %��¼�ӿ���Ŀ��������
vals{ii}=[];

%�ֱ��ò�ͬ��С�����Ϣ���ӿ����ݱ�������ά����valsl ��val6�У��ӿ���Ŀ������ct������
for ii = 1:6
    [vals{ii} ,r,c] = qtgetblk(I1,S2, 2^(ii-1));
    ct(ii) = size(vals{ii},3);
end

%% ������Ѻϲ�-��д����
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

