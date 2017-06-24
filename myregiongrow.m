function out_image = myregiongrow( input_image, growCriterion, threshhold )
%MYREGIONGROW 自写区域生长函数
%   getpts:暂时交互选择种子点
%   seed: 'auto'自动选择种子点：聚类，
%         长度不定，种子点数目代表聚类数目
%   growCriterion: 生长规则类型
%         grayDifference: 基于灰度差
%         kolmogorovSmirnov: 基于区域内灰度统计1
%         smoothedDifference：基于区域内灰度统计2
%         shape1： 基于区域形状1
%         shape2： 基于区域形状2
%  如何设定判断条件的阈值？？

%图像初始化
I = im2double(input_image);   %0-1
[M,N]=size(I);
out_image = zeros(M,N);

% 选择种子起始点
figure,imshow(I),title('原始图像');
[y,x]=getpts;
num_seed = length(x);
for s = 1:num_seed
    out_image(round(x(s)),round(y(s))) = 1;   %下标索引必须为整数
end
%x0 = round(x);
%y0 = round(y);
%seed = I(x,y);

% 主体部分
if strcmp(growCriterion,'grayDifference')    % 基于灰度差
    flag = 1;
    while flag
        flag = 0;
        for i = 1:M
            for j = 1:N
                if out_image(i,j)==1&&i~=1&&j~=1&&i~=M&&j~=N  %??? 防止边界
                    
                    % 寻1找邻域中相似点
                    % 该函数均为8连通
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
    % 把像素分成互不重叠的小区域  （如何分成小区域？？？）
    % 比较邻接区域的累积灰度直方图，根据灰度分布的相似性进行区域合并
    % 设定终止规则，通过反复进行步骤2中的操作将各个区域一次合并直到满足终止准则

elseif strcmp(growCriterion,'smoothedDifference')
    
elseif strcmp(growCriterion,'shape1')
    
elseif strcmp(growCriterion,'shape2')
        
end

if isa(input_image, 'uint8') % uint8
   out_image = im2uint8(out_image);
elseif isa(input_image, 'uint16')
    out_image = im2uint16(out_image);
% 其它情况，输出双精度类型的图像
end


