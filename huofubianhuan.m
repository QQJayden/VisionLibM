I = imread('circuit.tif');
% figure;
% imshow(I);title('Source');
rotI=imrotate(I,33,'crop');%��ת????����ת�ɷ�
BW=edge(rotI,'canny');

[H,T,R]=hough(BW);%����任
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
%hough����ͷ�ֵ�� 
%Ĭ������ʾ0~255,����[]����ʾmin(A)~max(A) 
%'InitialMagnification','fit'  100%��ʾ
xlabel('\theta'),ylabel('\rho');
axis on,axis normal,hold on;%��ʾ�����ᣬ����̶ȣ�����

%Ѱ��ǰ5���������ֵ0.3���ķ�ֵ
P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));%ceil(x)����X����С����
x=T(P(:,2));y=R(P(:,1));%����������ת��Ϊ����
plot(x,y,'s','color','white');%�����ֵλ��

lines=houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);%�ϲ�����С��5����С������ֵ7
figure,imshow(rotI),hold on;
max_len=0;
for k=1:length(lines)  %��������߶�
    xy=[lines(k).point1;lines(k).point2];
    plot(xy(:,1),xy(:,2),'x','LineWidth',2,'Color','green');
    
    %�����߶ζ˵�
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
    %ȷ����޶�
    len=norm(lines(k).point1-lines(k).point2);
    if(len>max_len)
        max_len=len;
        xy_long=xy;
    end
end
%������߶�
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');

