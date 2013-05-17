function [ dfm,dsk,dsb ] = bpsubsampling( dsfm,sfm,fm, sk,sb,sw,ss)
%���ز�������з��򴫲�
%dsfm �ز����������ƫ����
%sfm �ز���������
%in ����
%sk ��������Ȩֵ
%sb ƫ��
%sw ���ڴ�С
%ss ����
[X,Y,Z,dims]=size(fm);
dsfm=dsfm.*dsigmoid(sfm);
dfm=zeros(size(fm));
dsk=zeros(size(sk));
dsb=zeros(size(sb));
dsfm=dsfm.*dsigmoid(in);
kernel=ones(sw,sw);
for ii=1:dims
    this_dsfm=dsfm(:,:,:,ii);
    this_kernel=kernel*sk(ii);
    dsb(ii)=sum(this_dsfm(:));
    kx=X-sw+1;
    ky=Y-sw+1;
    dsfm_bfSubsampling=zeros(kx,ky);
    dsfm_bfSubsampling(1:ss:end,1:ss:end)=this_kernel;
    dsfm(:,:,:,ii)=dconv3_in(dsfm_bfSubsampling,fm(:,:,:,ii),this_kernel,'valid');
    dthis_kernel=donv3_in(dsfm_bfSubsampling,fm(:,:,:,ii),this_kernel,'valid');
    dsk(ii)=sum(dthis_kernel(:));
end
end

