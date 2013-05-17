function [ dsfm,dk1,db1,dk2,db2 ] = bpclassifier( dfm2,sfm, fm1,fm2,k1,b1,k2,b2)
%�Է��������з��򴫲�
%dfm ������������ƫ����
%sfm �������������������������
%fm1 ��������������
%fm2 ���������

%����㷴�򴫲�
dfm2=dfm2.*dsigmoid(fm2);
loop=size(b2,2);
dk2=zeros(size(k2));
db2=zeros(size(b2));
dfm1=zeros(size(fm1));
for ii=1:loop
    this_fm2=fm2(ii);
    this_k2=k2(:,ii);
    this_dout=dfm2(ii);
    db2(ii)=sum(this_k2*this_fm2);
    [this_dfm1,dk2(:,ii)]=grade(this_dout,fm1,this_k2);
    dfm1=dfm1+this_dfm1;
end
%���ز�
dfm1=dfm1.*dsigmoid(fm1);
loop=size(b1,2);
dsfm=zeros(size(sfm));
dk1=zeros(size(k1));
db1=zeros(size(b1));
for ii = 1:loop
    this_dfm1=dfm1(ii);
    this_fm1=fm1(ii);
    db1=this_dfm1;
    this_k1=k1(:,:,:,:,ii);
    [this_din,dk1(:,:,:,:,ii)]=dconv4(this_dfm1,this_fm1,sfm,this_k1);
    dsfm=dsfm+this_din;
end
end

function [din,dk]=grade(dout,in,k)
    din=zeros(size(in));
    dk=zeros(size(k));
    num=size(k,1);
    for jj=1:num
        this_k=k(jj);
        this_dk=dout.*in;
        dk(jj)=sum(this_dk);
        this_din = dout.*this_k;
        din(jj)=this_din;
    end
        
end
function [din,dk]=dconv4(dout,out,in,k)
    din=zeros(size(in));
    dk=zeros(size(k));
    num=size(k,4);
    for ii=1:num
        this_in=in(:,:,:,ii);
        this_k=k(:,:,:,ii);
        din(:,:,:,ii)=donv3_in(dout,this_in,this_k,'valid');
        this_dk=dconv3_k(dout,this_in,this_k,'valid');
        dk(:,:,:,ii)=this_dk;
    end
end
