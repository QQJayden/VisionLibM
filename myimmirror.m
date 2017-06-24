function imout = myimmirror( A, type )
%MYIMMRROR 自写的图像镜像函数
%   暂时只针对灰度图像
%   I  图像
%   type:vertical竖直/horizontal水平/transpose转置

[M,N] = size(A);
I = im2double(A);		% 将输入图像转换为双精度类型 0-1

%初始化
imout=zeros(M,N);

%主体
% if strcmp(type,'vertical')    %判断两字符串是否相等
%     for i=1:M
%         for j=1:N
%             imout(i,j)=I(M+1-i,j);
%         end
%     end
% elseif strcmp(type,'horizontal')
%     for i=1:M
%         for j=1:N
%             imout(i,j)=I(i,N+1-j);
%         end
%     end
% else return;
% end

%镜像：只用一个循环
if strcmp(type,'vertical')    %判断两字符串是否相等
    for i=1:M
        imout(i,:)=I(M+1-i,:);
    end
elseif strcmp(type,'horizontal')
    for j=1:N
        imout(:,j)=I(:,N+1-j);
    end
elseif strcmp(type,'transpose')
    imout=zeros(N,M);
    for i=1:N
        for j=1:M
            imout(i,j)=I(j,i);
        end
    end
else return;
end

%转换图像
if isa(A, 'uint8') % uint8
   imout = im2uint8(imout);
elseif isa(A, 'uint16')
    imout = im2uint16(imout);
% 其它情况，输出双精度类型的图像
end
        


end

