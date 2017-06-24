function out_thresh = mygraythresh( I, type )
%MYGRAYTHRESH ��д  �Զ�ȷ��ͼ����ֵ
%   type�������䷽��    ostu 
%         ����ѡ����ֵ��  iteration
%         ��С������  mmse:
%    else ֱ��ͼ�ȵ�
%    ��ʱΪ��ֵ������ֵ
%    �ж����ֵ�������ȷ�������ֵ

if ~isempty(I)
  I = im2uint8(I(:));   %����ֱ��ͼ����
  num_bins = 256;
  [counts,~] = imhist(I,num_bins);   %1-256
  
  %��ʼ��
  out_thresh = 0;

  counts_sum = sum(counts);   %��������
%   for i = 1:256
%       counts_sum = counts_sum + counts(i);
%   end
  
  
  %�����䷽��
  if strcmp(type,'ostu')
       U = sum((1:256)*counts/counts_sum);            %����ͼ��ĻҶ�ƽ��ֵ
       
%        for j0 = 1:256
%            U = U + counts(j0)/counts_sum;
%        end
      
      % ����һ�����ѭ���������䷽��
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
          
          %�ؼ������������,֮ǰд�ĳ�����
          if Ft>=Fostu
              Fostu = Ft;                  
              out_thresh = T;
          end
      end
      %[~,out_thresh]=max(Fostu);
      
      % find����Ҳ�������ֵ����λ��
      out_thresh = (out_thresh-1)/255;

      % ����������������+��Լ����С��������
      % arrayfun ��߼����,ʵ�ֺ���Ƕ��
      % syms k
      % symsum((k.^2+7*k).^3,1,100)
%       Tx = 1:T;
%       W0 = @(Tx)sum(count(Tx(:))/counts_sum); % C0�����ĸ���
%       W1 = 1 - W0;
%       U0 = @(Tx)sum(count(Tx(:))/counts_sum); % C0�����ĸ���
%       Fthresh = @()
%       
  %������ѡ����ֵ    
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
 
  %��С�������    
  elseif strcmp(type,'mmse')
      
      
  %���عȵ���Сֵ : �����ף��ֲ��Ŷ�̫��
  %һά��ɢ���ݵľֲ���Сֵ��counts��
  %else                             
      
  end
else
  out_thresh = 0.0;
end

