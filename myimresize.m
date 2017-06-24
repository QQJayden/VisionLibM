function imout = myimresize( varargin )
%MYIMRESIZE ͼ������,��ʱֻ��ԻҶ�ͼ��
%   A  ͼ��
%   scale ��������/ [Sx,Sy]������������������
%   method ��ֵ����:
%          nearest����ڲ�ֵ
%          linear˫���Բ�ֵ
%          cubic˫���β�ֵ
%   interp2(X,Y,V,Xq,Yq,Method)  ��ά��ֵ����
%   �����Լ���д��ֵ����������
%   ��ε���д����ֵ����
%   ȡ�� fix��0����floor��-����ceil(+),round���������룩

[A, scale, Sx, Sy, method] = parse_inputs(varargin{:});

%��ʼ��
[M,N] = size(A);
I = im2double(A);		% ������ͼ��ת��Ϊ˫�������� 0-1

%Ԥ�����ж���������ʽ
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

%����ѭ��
for i=1:M0
    for j=1:N0
        if strcmp(method,'nearest')       %����ڲ�ֵ
            imout(i,j)=I(round(i/x),round(j/y));
        elseif strcmp(method,'linear')    %˫���Բ�ֵ
                        
        elseif strcmp(method,'cubic')     %˫���β�ֵ
            
        else error('wrong interportation method');
        end
    end
end

%ת��ͼ��
if isa(A, 'uint8') % uint8
   imout = im2uint8(imout);
elseif isa(A, 'uint16')
    imout = im2uint16(imout);
% ������������˫�������͵�ͼ��
end
        
end
%% 
function [A, scale, Sx, Sy, method] = parse_inputs(varargin)
% ����������������������������Ч�Եĺ���parse_inputs
% A       ����ͼ����ʱ��Ϊ�Ҷ�ͼ (2D)

%�����ܲ�ȡ�Ĳ����ÿ�
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

% ��������������Ч��
 
% ��int16���͵ľ���ת����uint16����
if isa(A,'int16')
  A = int16touint16(A);
end
end
