function imout = myimresize( varargin )
%MYIMRESIZE 图像缩放,暂时只针对灰度图像
%   A  图像
%   scale 缩放因子/ [Sx,Sy]，两个方向缩放因子
%   method 插值方法:
%          nearest最近邻插值
%          linear双线性插值
%          cubic双三次插值
%   interp2(X,Y,V,Xq,Yq,Method)  二维插值函数
%   考虑自己编写插值函数？？？
%   如何单独写出插值函数
%   取整 fix（0），floor（-），ceil(+),round（四舍五入）

[A, scale, Sx, Sy, method] = parse_inputs(varargin{:});

%初始化
[M,N] = size(A);
I = im2double(A);		% 将输入图像转换为双精度类型 0-1

%预处理，判断是哪种形式
if ~isempty(scale)&&isempty(Sx)&&isempty(Sy)
    M0 = round(M*scale);
    N0 = round(N*scale);
    x=scale;
    y=scale;
elseif isempty(scale)&&~isempty(Sx)&&~isempty(Sy)
    M0 = round(M*Sx);
    N0 = round(N*Sy);
    x=Sx;
    y=Sy;
else 
    return;
end
imout = zeros(M0,N0);

%主体循环
for i=1:M0
    for j=1:N0
        if strcmp(method,'nearest')       %最近邻插值
            imout(i,j)=I(round(i/x),round(j/y));
        elseif strcmp(method,'linear')    %双线性插值
                        
        elseif strcmp(method,'cubic')     %双三次插值
            
        else error('wrong interportation method');
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
%% 
function [A, scale, Sx, Sy, method] = parse_inputs(varargin)
% 这就是用来分析输入参数个数和有效性的函数parse_inputs
% A       输入图像，暂时均为灰度图 (2D)

%将可能不取的参数置空
scale=[];
Sx=[];
Sy=[];

switch length(varargin{2})
    case 1
        A = varargin{1};
        scale = varargin{2};
        method = varargin{3};
    case 2
        A = varargin{1};
        Sx = varargin{2}(1);
        Sy = varargin{2}(2);
        method = varargin{3};
        
end

% 检测输入参数的有效性
 
% 将int16类型的矩阵转换成uint16类型
if isa(A,'int16')
  A = int16touint16(A);
end
end
