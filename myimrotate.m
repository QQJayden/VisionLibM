function imout = myimrotate( varargin )
%MYIMROTATE 自写图像旋转
%   暂时仅限灰度图像
%   旋转为绕中心逆时针旋转
%   插值默认为最近邻插值
%   iscut  是否裁剪，
%   注意还要坐标系变换
%   取整 fix（0），floor（-），ceil(+),round（四舍五入）
%   边界问题与十字线问题

[A, alpha, interp_type, iscut] = parse_inputs(varargin{:});

%初始化
[M,N] = size(A);
I = im2double(A);		% 将输入图像转换为双精度类型 0-1
alpha=deg2rad(alpha);   % 将角度转化为弧度计算

%函数主体
if strcmp(iscut,'crop')      %裁剪：大小和原图一样
    imout=zeros(M,N);        %初始化
    for i=1:M                % 主体
        for j=1:N           
            if strcmp(interp_type,'nearest')       %最近邻插值
                x0=round((i-M/2.0)*cos(alpha)+(j-N/2.0)*sin(alpha)+M/2.0);
                y0=round(-(i-M/2.0)*sin(alpha)+(j-N/2.0)*cos(alpha)+N/2.0);
                
                if x0>=1&&x0<=M&&y0>=1&&y0<=N
                    imout(i,j)=I(x0,y0);
                end 
            elseif strcmp(interp_type,'linear')    %双线性插值
                x0=(i-M/2.0)*cos(alpha)+(j-N/2.0)*sin(alpha)+M/2.0;
                y0=-(i-M/2.0)*sin(alpha)+(j-N/2.0)*cos(alpha)+N/2.0;
                x1=floor(x0);y1=floor(y0);    %四个插值点
                x2=floor(x0);y2=ceil(y0);
                x3=ceil(x0);y3=floor(y0);
                x4=ceil(x0);y4=ceil(y0);
                %计算过程
                if x0>=1&&x0<=M&&y0>=1&&y0<=N           
                    if abs(x0-N)<0.001  %右边界
                        if abs(y0-M)<0.001
                            imout(i,j)=I(x1,y1);
                        else
                            imout(i,j)=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
                        end
                    elseif abs(x0-N)<0.001  %下边界
                        imout(i,j)=I(x1,y1)+(y0-y1)*(I(x2,y2)-I(x1,y1));
                    else
                        imout1=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
                        imout2=I(x2,y2)+(x0-x2)*(I(x4,y4)-I(x2,y2));
                        imout(i,j)=imout1+(y0-y1)*(imout2-imout1);
                    end
%                         
%             elseif strcmp(method,'cubic')     %双三次插值
%             
%             else error('wrong interportation method')
                end
                
%                 if x0>=1&&x0<=M&&y0>=1&&y0<=N
%                     imout1=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
%                     imout2=I(x2,y2)+(x0-x2)*(I(x4,y4)-I(x2,y2));
%                     imout(i,j)=imout1+(y0-y1)*(imout2-imout1);
% % 
% %                     %下面计算会产生十字虚线，变量x0分成两项增加了误差
% %                     imout1=(-(x0-x3))*I(x1,y1)+((x0-x1))*I(x3,y3);
% %                     imout2=(-(x0-x4))*I(x2,y2)+((x0-x2))*I(x4,y4);
% %                     imout(i,j)=(-(y0-y2))*imout1+((y0-y1))*imout2;
% 
%                 end
%                         
%             elseif strcmp(method,'cubic')     %双三次插值
%             
%             else error('wrong interportation method');
            end
        end
            
    end
elseif isempty(iscut)        %不裁剪
    M0 = round(M*cos(alpha)+N*sin(alpha));
    N0 = round(M*sin(alpha)+N*cos(alpha));
    imout=zeros(M0,N0);        %初始化
    for i=1:M0                % 主体
        for j=1:N0           
            if strcmp(interp_type,'nearest')       %最近邻插值
                x0=round((i-M0/2.0)*cos(alpha)+(j-N0/2.0)*sin(alpha)+M/2.0);
                y0=round(-(i-M0/2.0)*sin(alpha)+(j-N0/2.0)*cos(alpha)+N/2.0);
                
                if x0>=1&&x0<=M&&y0>=1&&y0<=N
                    imout(i,j)=I(x0,y0);
                end
                
             elseif strcmp(interp_type,'linear')    %双线性插值
                x0=(i-M0/2.0)*cos(alpha)+(j-N0/2.0)*sin(alpha)+M/2.0;
                y0=-(i-M0/2.0)*sin(alpha)+(j-N0/2.0)*cos(alpha)+N/2.0;
                x1=floor(x0);y1=floor(y0);    %四个插值点
                x2=floor(x0);y2=ceil(y0);
                x3=ceil(x0);y3=floor(y0);
                x4=ceil(x0);y4=ceil(y0);
                %计算过程           
                if x0>=1&&x0<=M&&y0>=1&&y0<=N           
                    if abs(x0-N)<0.001  %右边界
                        if abs(y0-M)<0.001
                            imout(i,j)=I(x1,y1);
                        else
                            imout(i,j)=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
                        end
                    elseif abs(x0-N)<0.001  %下边界
                        imout(i,j)=I(x1,y1)+(y0-y1)*(I(x2,y2)-I(x1,y1));
                    else
                        imout1=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
                        imout2=I(x2,y2)+(x0-x2)*(I(x4,y4)-I(x2,y2));
                        imout(i,j)=imout1+(y0-y1)*(imout2-imout1);
                    end
%                         
%             elseif strcmp(method,'cubic')     %双三次插值
%             
%             else error('wrong interportation method')
                end
            end
            
        end
       
    end

%转换图像
if isa(A, 'uint8') % uint8
   imout = im2uint8(imout);
elseif isa(A, 'uint16')
    imout = im2uint16(imout);
% 其它情况，输出双精度类型的图像
end

end
end

%% 取值函数
function [A, alpha, interp_type, iscut] = parse_inputs(varargin)
% 这就是用来分析输入参数个数和有效性的函数parse_inputs
% A       输入图像，暂时均为灰度图 (2D)

%将可能不取的参数置空
iscut=[];

switch nargin
    case 3
        A = varargin{1};
        alpha = varargin{2};
        interp_type = varargin{3};
    case 4
        A = varargin{1};
        alpha = varargin{2};
        interp_type = varargin{3};
        iscut = varargin{4};
end

% 检测输入参数的有效性
 
% 将int16类型的矩阵转换成uint16类型
if isa(A,'int16')
  A = int16touint16(A);
end
end