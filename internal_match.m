function [ y ] = internal_match( varargin )
%internal_match:   Ѱ��ͼ���������ڽ�
%   �˴���ʾ��ϸ˵��
 %����ͼ����λ��
I=varargin{1};
i=varargin{2};
j=varargin{3};
if I(i,j)==0&&I(i,j+1)==1&&I(i+1,j)==1&&I(i+1,j+1)==1 
            y=1;
elseif I(i,j)==1&&I(i,j+1)==0&&I(i+1,j)==1&&I(i+1,j+1)==1 
            y=1;
elseif I(i,j)==1&&I(i,j+1)==1&&I(i+1,j)==0&&I(i+1,j+1)==1 
            y=1;
elseif I(i,j)==1&&I(i,j+1)==1&&I(i+1,j)==1&&I(i+1,j+1)==0 
            y=1;
else y=0;
end



