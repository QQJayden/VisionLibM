function [ h, theta, rho ] = myhough_lines( BW, dtheta, drho )
%MYHOUGH  自写直线的霍夫变换
%     BW: 边缘检测之后得到的二值图像
%     hough: 得到的霍夫矩阵
%     theta/rho: 得到每一行每一列极坐标参数向量
%     dtheta/drho: 对应单位区间长度
%     暂时默认间隔为1

%输入参数判定
if nargin<3
    drho = 1;
end
if nargin < 2
    dtheta = 1;
end

%初始化
I = im2double(BW); %归一化
[M,N] = size(I);

%单位长度暂时为1
theta = -89:90;
ntheta = length(theta);
rho_max = ceil(sqrt(M^2 + N^2));
rho = 0:rho_max;
nrho = length(rho);

h = zeros(nrho, ntheta);

% theta = linspace(-90 , 0, ceil(90/dtheta) + l);
% theta = [theta  -fliplr(theta(2:end-l))];
% ntheta = length(theta);
% D = sqrt((M - 1)^2 + (N - 1)^2) ;
% q = ceil(D/drho);
% nrho = 2*q - l;
% rho = linspace(-q*drho, q*drho, nrho);

%函数主体
for i = 1:M
    for j = 1:N
        if I(i,j)==1
            for t=-89:90
                theta_rad = t*pi/180;
                nrho_new = round(abs(i*cos(theta_rad)+j*sin(theta_rad)))+1;
                ntheta_new = t + 90;
                h(nrho_new, ntheta_new) = h(nrho_new, ntheta_new) + 1;   
            end
        end
    end
end

end

