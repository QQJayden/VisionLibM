function out_thresh = mygraythresh( I, type )
%MYGRAYTHRESH 自写  自动确定图像阈值
%   type：最大类间方差    ostu 
%         迭代选择阈值法  iteration
%         最小均方误差法  mmse:
%    else 直方图谷底
%    暂时为二值化的阈值
%    有多个峰值的情况需确定多个阈值

if ~isempty(I)
  I = im2uint8(I(:));   %便于直方图计算
  num_bins = 256;
  [counts,~] = imhist(I,num_bins);   %1-256
  
  %初始化
  out_thresh = 0;

  counts_sum = sum(counts);   %像素总数
%   for i = 1:256
%       counts_sum = counts_sum + counts(i);
%   end
  
  
  %最大类间方差
  if strcmp(type,'ostu')
       U = sum((1:256)*counts/counts_sum);            %整体图像的灰度平均值
       
%        for j0 = 1:256
%            U = U + counts(j0)/counts_sum;
%        end
      
      % 方法一：多层循环求最大类间方差
      %Fostu = zeros(1,256);
      Fostu = 0;
      Wt = 0;
      Ut = 0;
      for T = 1:256
          Wt = Wt + counts(T)/counts_sum;
          Ut = Ut + T*counts(T)/counts_sum;
          
          W0 = Wt;
          W1 = 1 - W0;
          U0 = Ut/Wt;
          U1 = (U-Ut)/(1-Wt);
          Ft = W0*W1*(U1-U0)*(U1-U0);
          %Fostu(T) = Ft;
          
          %关键问题出在这里,之前写的出问题
          if Ft>=Fostu
              Fostu = Ft;                  
              out_thresh = T;
          end
      end
      %[~,out_thresh]=max(Fostu);
      
      % find函数也可求最大值所在位置
      out_thresh = (out_thresh-1)/255;

      % 方法二：匿名函数+无约束最小化？？？
      % arrayfun 提高简洁性,实现函数嵌套
      % syms k
      % symsum((k.^2+7*k).^3,1,100)
%       Tx = 1:T;
%       W0 = @(Tx)sum(count(Tx(:))/counts_sum); % C0产生的概率
%       W1 = 1 - W0;
%       U0 = @(Tx)sum(count(Tx(:))/counts_sum); % C0产生的概率
%       Fthresh = @()
%       
  %迭代法选择阈值    
  elseif strcmp(type,'iteration') 
      T2 = 0.5*(max(max(I)+min(min(I))));
      delta = 1;
      while delta>=0.5
%           g = I>=T2;
%           T2new = 0.5*(mean(I(g))+mean(I(~g)));
          T2new = 0.5*(mean(I(I>=T2))+mean(I(I<T2)));
          delta = abs(T2new-T2);
          T2 = T2new;
      end
      out_thresh = T2/255;
 
  %最小均方误差    
  elseif strcmp(type,'mmse')
      
      
  %返回谷底最小值 : 不靠谱，局部扰动太大
  %一维离散数据的局部极小值（counts）
  %else                             
      
  end
else
  out_thresh = 0.0;
end

