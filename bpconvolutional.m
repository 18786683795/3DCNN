function [dfm ,dk,db]= bpconvolutional( dcfm,cfm,fm,k,b,ct )
%�Ծ������з��򴫲�
%����
%dcfm �ز�����ķ��򴫲����
%cfm ��������
%k �����ľ����
%b ������ƫ��
%���
%fm dfm
num=size(k,4);
dfm=zeros(size(fm));
dk=zeros(size(k));
db=zeros(size(b));
dcfm=dcfm.*dsigmod(cfm);
for ii = 1:length(b)
    this_dcfm = dcfm(:,:,ii);
    db(ii) = sum(this_dcfm(:));
end
for ii=1:num
    this_fm=fm(:,:,:,ct(ii,1));
    this_k=k(:,:,:,ii);
    this_dcfm=dcfm(:,:,:,ct(ii,2));
    this_fm=dconv3_in(this_dcfm,this_fm,this_k,'valid');
    dfm(:,:,:,ct(ii,1))=dfm(:,:,:,ct(ii,1))+this_fm;
    this_k=dconv3_k(this_dcfm,this_fm,this_k,'valid');
    dk(:,:,:,ii)=this_k;
end
end

