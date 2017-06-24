function imout = myimmirror( A, type )
%MYIMMRROR ��д��ͼ������
%   ��ʱֻ��ԻҶ�ͼ��
%   I  ͼ��
%   type:vertical��ֱ/horizontalˮƽ/transposeת��

[M,N] = size(A);
I = im2double(A);		% ������ͼ��ת��Ϊ˫�������� 0-1

%��ʼ��
imout=zeros(M,N);

%����
% if strcmp(type,'vertical')    %�ж����ַ����Ƿ����
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

%����ֻ��һ��ѭ��
if strcmp(type,'vertical')    %�ж����ַ����Ƿ����
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

%ת��ͼ��
if isa(A, 'uint8') % uint8
   imout = im2uint8(imout);
elseif isa(A, 'uint16')
    imout = im2uint16(imout);
% ������������˫�������͵�ͼ��
end
        


end

