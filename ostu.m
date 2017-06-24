function level = myostu( image )
%MYOSTU �ú������������䷽��ostu�㷨,�������ֵ
%   �˴���ʾ��ϸ˵��
ranks=256;
counts=imhist(image,ranks);
p=counts/sum(counts);
omega=cumsum(p);
mu=cumsum(p.*(0:ranks-1)');
mu_t = mu(end);
sigma2 = 0; %otsu��䷽��
h=0;
Hmax=0;
w0 = 0;
w1=0;
u0=0;
u1=0;
HStore=zeros(1,256);
for i=1:ranks
    if (1-omega(i)==0)
        continue;
    end;
    w0=omega(i);
    w1=1-w0;
    u0=mu(i)/w0;
    u1=(mu_t-mu(i))/w1;
    sigma2 = w0*(u0-mu_t).^2+w1*(u1-mu_t).^2;
    h=sigma2;
    HStore(i)=h;
end
Hmax = max(HStore);
idx = find(HStore == Hmax);
level = (idx - 1) / (ranks - 1);


end

