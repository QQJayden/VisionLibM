function imout = myimrotate( varargin )
%MYIMROTATE ��дͼ����ת
%   ��ʱ���޻Ҷ�ͼ��
%   ��תΪ��������ʱ����ת
%   ��ֵĬ��Ϊ����ڲ�ֵ
%   iscut  �Ƿ�ü���
%   ע�⻹Ҫ����ϵ�任
%   ȡ�� fix��0����floor��-����ceil(+),round���������룩
%   �߽�������ʮ��������

[A, alpha, interp_type, iscut] = parse_inputs(varargin{:});

%��ʼ��
[M,N] = size(A);
I = im2double(A);		% ������ͼ��ת��Ϊ˫�������� 0-1
alpha=deg2rad(alpha);   % ���Ƕ�ת��Ϊ���ȼ���

%��������
if strcmp(iscut,'crop')      %�ü�����С��ԭͼһ��
    imout=zeros(M,N);        %��ʼ��
    for i=1:M                % ����
        for j=1:N           
            if strcmp(interp_type,'nearest')       %����ڲ�ֵ
                x0=round((i-M/2.0)*cos(alpha)+(j-N/2.0)*sin(alpha)+M/2.0);
                y0=round(-(i-M/2.0)*sin(alpha)+(j-N/2.0)*cos(alpha)+N/2.0);
                
                if x0>=1&&x0<=M&&y0>=1&&y0<=N
                    imout(i,j)=I(x0,y0);
                end 
            elseif strcmp(interp_type,'linear')    %˫���Բ�ֵ
                x0=(i-M/2.0)*cos(alpha)+(j-N/2.0)*sin(alpha)+M/2.0;
                y0=-(i-M/2.0)*sin(alpha)+(j-N/2.0)*cos(alpha)+N/2.0;
                x1=floor(x0);y1=floor(y0);    %�ĸ���ֵ��
                x2=floor(x0);y2=ceil(y0);
                x3=ceil(x0);y3=floor(y0);
                x4=ceil(x0);y4=ceil(y0);
                %�������
                if x0>=1&&x0<=M&&y0>=1&&y0<=N           
                    if abs(x0-N)<0.001  %�ұ߽�
                        if abs(y0-M)<0.001
                            imout(i,j)=I(x1,y1);
                        else
                            imout(i,j)=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
                        end
                    elseif abs(x0-N)<0.001  %�±߽�
                        imout(i,j)=I(x1,y1)+(y0-y1)*(I(x2,y2)-I(x1,y1));
                    else
                        imout1=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
                        imout2=I(x2,y2)+(x0-x2)*(I(x4,y4)-I(x2,y2));
                        imout(i,j)=imout1+(y0-y1)*(imout2-imout1);
                    end
%                         
%             elseif strcmp(method,'cubic')     %˫���β�ֵ
%             
%             else error('wrong interportation method')
                end
                
%                 if x0>=1&&x0<=M&&y0>=1&&y0<=N
%                     imout1=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
%                     imout2=I(x2,y2)+(x0-x2)*(I(x4,y4)-I(x2,y2));
%                     imout(i,j)=imout1+(y0-y1)*(imout2-imout1);
% % 
% %                     %�����������ʮ�����ߣ�����x0�ֳ��������������
% %                     imout1=(-(x0-x3))*I(x1,y1)+((x0-x1))*I(x3,y3);
% %                     imout2=(-(x0-x4))*I(x2,y2)+((x0-x2))*I(x4,y4);
% %                     imout(i,j)=(-(y0-y2))*imout1+((y0-y1))*imout2;
% 
%                 end
%                         
%             elseif strcmp(method,'cubic')     %˫���β�ֵ
%             
%             else error('wrong interportation method');
            end
        end
            
    end
elseif isempty(iscut)        %���ü�
    M0 = round(M*cos(alpha)+N*sin(alpha));
    N0 = round(M*sin(alpha)+N*cos(alpha));
    imout=zeros(M0,N0);        %��ʼ��
    for i=1:M0                % ����
        for j=1:N0           
            if strcmp(interp_type,'nearest')       %����ڲ�ֵ
                x0=round((i-M0/2.0)*cos(alpha)+(j-N0/2.0)*sin(alpha)+M/2.0);
                y0=round(-(i-M0/2.0)*sin(alpha)+(j-N0/2.0)*cos(alpha)+N/2.0);
                
                if x0>=1&&x0<=M&&y0>=1&&y0<=N
                    imout(i,j)=I(x0,y0);
                end
                
             elseif strcmp(interp_type,'linear')    %˫���Բ�ֵ
                x0=(i-M0/2.0)*cos(alpha)+(j-N0/2.0)*sin(alpha)+M/2.0;
                y0=-(i-M0/2.0)*sin(alpha)+(j-N0/2.0)*cos(alpha)+N/2.0;
                x1=floor(x0);y1=floor(y0);    %�ĸ���ֵ��
                x2=floor(x0);y2=ceil(y0);
                x3=ceil(x0);y3=floor(y0);
                x4=ceil(x0);y4=ceil(y0);
                %�������           
                if x0>=1&&x0<=M&&y0>=1&&y0<=N           
                    if abs(x0-N)<0.001  %�ұ߽�
                        if abs(y0-M)<0.001
                            imout(i,j)=I(x1,y1);
                        else
                            imout(i,j)=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
                        end
                    elseif abs(x0-N)<0.001  %�±߽�
                        imout(i,j)=I(x1,y1)+(y0-y1)*(I(x2,y2)-I(x1,y1));
                    else
                        imout1=I(x1,y1)+(x0-x1)*(I(x3,y3)-I(x1,y1));
                        imout2=I(x2,y2)+(x0-x2)*(I(x4,y4)-I(x2,y2));
                        imout(i,j)=imout1+(y0-y1)*(imout2-imout1);
                    end
%                         
%             elseif strcmp(method,'cubic')     %˫���β�ֵ
%             
%             else error('wrong interportation method')
                end
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
end

%% ȡֵ����
function [A, alpha, interp_type, iscut] = parse_inputs(varargin)
% ����������������������������Ч�Եĺ���parse_inputs
% A       ����ͼ����ʱ��Ϊ�Ҷ�ͼ (2D)

%�����ܲ�ȡ�Ĳ����ÿ�
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

% ��������������Ч��
 
% ��int16���͵ľ���ת����uint16����
if isa(A,'int16')
  A = int16touint16(A);
end
end