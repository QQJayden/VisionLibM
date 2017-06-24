function outimage = myimmove(varargin )
%MYIMMOVE �˴���ʾ�йش˺�����ժҪ
%   x,y ��ʾƫ�Ƶ�λ�ƴ�С
%   �˴���ʾ��ϸ˵��
%����[80 50�ݿ����޸ģ� �޸ĺ�ƽ�ƾ����Ӧ�ı�
[A, map, x, y] = parse_inputs(varargin{:});


% �������ͼ���ǻҶ�ͼ������Ҫִ��ת��
if ndims(A)==3,% A����Ϊ3ά��RGBͼ��
  A = rgb2gray(A);
elseif ~isempty(map),% MAP����Ϊ�ǿգ�����ͼ��
  A = ind2gray(A,map);
end % �ԻҶ�ͼ������Ҫת��
 
% ��ȡԭʼͼ��Ĵ�С����ʼ�����ͼ��
[m,n] = size(A);
I = im2double(A);		% ������ͼ��ת��Ϊ˫��������
outimage = zeros(m,n);

% myimmove(I,x,y ),Ĭ�ϻ���������
%��������
for i=1:m
    for j=1:n
        if (i-x)>=1&&(j-y)>=1&&(i-x)<=m&&(j-y)<=n
            outimage(i,j)=I(i-x,j-y);
        end
    end
end

if isa(I, 'uint8') % uint8
    outimage = im2uint8(outimage);
elseif isa(I, 'uint16')
    outimage = im2uint16(outimage);
% ������������˫�������͵�ͼ��
end
end

%-----------------------------------------------------------------------------
function [A, map, x, y] = parse_inputs(varargin)
% ����������������������������Ч�Եĺ���parse_inputs
% A       ����ͼ��RGBͼ (3D), �Ҷ�ͼ (2D), ��������ͼ (X)
% map     ����ͼ��ɫ�� (:,3)
% ���Ƚ���һ���յ�map����������������isempty(map)ʱ����
map = [];
 
%   IPTCHECKNARGIN(LOW,HIGH,NUM_INPUTS,FUNC_NAME) �����������ĸ����Ƿ�
%   ����Ҫ�󣬼�NUM_INPUTS�а�����������������Ƿ���LOW��HIGH��ָ���ķ�Χ
%   �ڡ�������ڷ�Χ�ڣ���˺�������һ����ʽ���Ĵ�����Ϣ��
iptchecknargin(2,3,nargin,mfilename);
 
%   IPTCHECKINPUT(A,CLASSES,ATTRIBUTES,FUNC_NAME,VAR_NAME, ARG_POS) ������
%   ����A�е�Ԫ���Ƿ����ڸ����������б��������Ԫ�ز����ڸ��������ͣ������
%   һ����ʽ���Ĵ�����Ϣ��
iptcheckinput(varargin{1},...
              {'uint8','uint16','int16','double'}, ...
              {'real', 'nonsparse'},mfilename,'I, X or RGB',1);
 
switch nargin
 case 2 
  A = varargin{1};
  x = varargin{2}(1);
  y = varargin{2}(2);
 case 3
  A = varargin{1};%               imgrayscaling(X, map, [x1,x2], [y1,y2])
  map = varargin{2};
  x = varargin{2}(1);
  y = varargin{2}(2);
end

% ��������������Ч��
% ���RGB����
if (ndims(A)==3) && (size(A,3)~=3)   
    msg = sprintf('%s: ���ɫͼ��Ӧ��ʹ��һ��M-N-3ά�ȵ�����', ...
                  upper(mfilename));
    eid = sprintf('Images:%s:trueColorRgbImageMustBeMbyNby3',mfilename);
    error(eid,'%s',msg);
end
 
if ~isempty(map) 
% ����ɫ��
  if (size(map,2) ~= 3) || ndims(map)>2
    msg1 = sprintf('%s: ����ĵ�ɫ��Ӧ����һ������', ...
                   upper(mfilename));
    msg2 = '��ӵ������';
    eid = sprintf('Images:%s:inColormapMustBe2Dwith3Cols',mfilename);
    error(eid,'%s %s',msg1,msg2);
    
  elseif (min(map(:))<0) || (max(map(:))>1)
    msg1 = sprintf('%s: ��ɫ���и���������ǿ�� ',upper(mfilename));
    msg2 = 'Ӧ����0��1֮��';
    eid = sprintf('Images:%s:colormapValsMustBe0to1',mfilename);
    error(eid,'%s %s',msg1,msg2);
  end
end
 
% ��int16���͵ľ���ת����uint16����
if isa(A,'int16')
  A = int16touint16(A);
end
end

