function out_image = myregiongrow( input_image, growCriterion, threshhold )
%MYREGIONGROW ��д������������
%   getpts:��ʱ����ѡ�����ӵ�
%   seed: 'auto'�Զ�ѡ�����ӵ㣺���࣬
%         ���Ȳ��������ӵ���Ŀ���������Ŀ
%   growCriterion: ������������
%         grayDifference: ���ڻҶȲ�
%         kolmogorovSmirnov: ���������ڻҶ�ͳ��1
%         smoothedDifference�����������ڻҶ�ͳ��2
%         shape1�� ����������״1
%         shape2�� ����������״2
%  ����趨�ж���������ֵ����

%ͼ���ʼ��
I = im2double(input_image);   %0-1
[M,N]=size(I);
out_image = zeros(M,N);

% ѡ��������ʼ��
figure,imshow(I),title('ԭʼͼ��');
[y,x]=getpts;
num_seed = length(x);
for s = 1:num_seed
    out_image(round(x(s)),round(y(s))) = 1;   %�±���������Ϊ����
end
%x0 = round(x);
%y0 = round(y);
%seed = I(x,y);

% ���岿��
if strcmp(growCriterion,'grayDifference')    % ���ڻҶȲ�
    flag = 1;
    while flag
        flag = 0;
        for i = 1:M
            for j = 1:N
                if out_image(i,j)==1&&i~=1&&j~=1&&i~=M&&j~=N  %??? ��ֹ�߽�
                    
                    % Ѱ1�����������Ƶ�
                    % �ú�����Ϊ8��ͨ
                    for k = -1:1
                        for p = -1:1
                            if out_image(i+k,j+p)==0&&abs(I(i+k,j+p)-I(i,j))<threshhold
                                flag = 1;
                                out_image(i+k,j+p)=1;
                            end
                        end
                    end
                end
            end
        end
    end
elseif strcmp(growCriterion,'kolmogorovSmirnov')
    % �����طֳɻ����ص���С����  ����ηֳ�С���򣿣�����
    % �Ƚ��ڽ�������ۻ��Ҷ�ֱ��ͼ�����ݻҶȷֲ��������Խ�������ϲ�
    % �趨��ֹ����ͨ���������в���2�еĲ�������������һ�κϲ�ֱ��������ֹ׼��

elseif strcmp(growCriterion,'smoothedDifference')
    
elseif strcmp(growCriterion,'shape1')
    
elseif strcmp(growCriterion,'shape2')
        
end

if isa(input_image, 'uint8') % uint8
   out_image = im2uint8(out_image);
elseif isa(input_image, 'uint16')
    out_image = im2uint16(out_image);
% ������������˫�������͵�ͼ��
end


