I = imread('circuit.tif');
% figure;
% imshow(I);title('Source');
rotI=imrotate(I,33,'crop');%旋转????不旋转可否
BW=edge(rotI,'canny');

[H,T,R]=hough(BW);%霍夫变换
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
%hough矩阵和峰值点 
%默认是显示0~255,用了[]就显示min(A)~max(A) 
%'InitialMagnification','fit'  100%显示
xlabel('\theta'),ylabel('\rho');
axis on,axis normal,hold on;%显示坐标轴，坐标刻度，保存

%寻找前5个大于最大值0.3倍的峰值
P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));%ceil(x)大于X的最小整数
x=T(P(:,2));y=R(P(:,1));%将行列索引转换为坐标
plot(x,y,'s','color','white');%标出峰值位置

lines=houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);%合并距离小于5，最小长度阈值7
figure,imshow(rotI),hold on;
max_len=0;
for k=1:length(lines)  %标出各条线段
    xy=[lines(k).point1;lines(k).point2];
    plot(xy(:,1),xy(:,2),'x','LineWidth',2,'Color','green');
    
    %绘制线段端点
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
    %确定最长限度
    len=norm(lines(k).point1-lines(k).point2);
    if(len>max_len)
        max_len=len;
        xy_long=xy;
    end
end
%高亮最长线段
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');

