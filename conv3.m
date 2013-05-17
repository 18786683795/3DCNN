function [result]=conv3(in,k,mode)
%��in����3ά���
%in ��ά����
%k ��ά�����
%mode ���ģʽ
if nargin==2
    mode='full';
end
%�����ȰѾ���˷�ת������matlab���ǴӾ�����һ��Ԫ�ؿ�ʼ����
%�Ȱ�ÿһ����ά�����ת180�ȣ�Ȼ���ٵߵ����ͼ��λ��
nk=size(k,3);
kernel=zeros(size(k));
for ii=0:nk-1
    kernel(:,:,ii+1)=k(:,:,nk-ii);
end
result=convn(in,kernel,mode);
end