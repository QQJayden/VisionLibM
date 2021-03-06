%% 空间域与频域图像处理
%  *自写滤波函数！！！*

%% 滤波：相关与卷积
% 相关：模板直接与图像进行乘积
% 卷积：模板翻转180°之后与图像进行卷积
%% 滤波：边界处理
% 1 收缩范围处理：忽略1像素宽的边界
% 2 使用常数填充图像
% 3 使用复制像素的方法填充图像： 复制本身边界的模式
%% 滤波操作
% imfilter   
% fspecial(type, parameters)  创建预定义的二维滤波器

%% 图像平滑
% 均值滤波 ：

% 高斯滤波 ：
% 如果σ过小， 偏离中心的所有像素权重将会非常小
% 如果σ过大，而邻域相对较小， 这样在邻域内高斯模板将退化为平均模板；

% 自适应平滑滤波： 噪声局部区域平滑
% 判断局部是否有灰度跳跃：
% 1 局部最大值与最小值之差大于阈值
% 2 局部区域方差大于某一阈值

%% 非线性滤波器

