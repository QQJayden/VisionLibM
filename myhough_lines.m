function [ h, theta, rho ] = myhough_lines( BW, dtheta, drho )
%MYHOUGH  ��дֱ�ߵĻ���任
%     BW: ��Ե���֮��õ��Ķ�ֵͼ��
%     hough: �õ��Ļ������
%     theta/rho: �õ�ÿһ��ÿһ�м������������
%     dtheta/drho: ��Ӧ��λ���䳤��
%     ��ʱĬ�ϼ��Ϊ1

%��������ж�
if nargin<3
    drho = 1;
end
if nargin < 2
    dtheta = 1;
end

%��ʼ��
I = im2double(BW); %��һ��
[M,N] = size(I);

%��λ������ʱΪ1
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

%��������
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

