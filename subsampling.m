function sfm= subsampling(cfm,sk,sb,sw,ss)
%�Ծ���������ͼ�����ز���
% cfm ����ͼ(4D)
%sk �ز�������(1D)
%sb ƫ��(1D)
%sw ���ڴ�С
%ss ����
cfmNum=size(cfm,4);
cfmZ=size(cfm,3);
cfmY=size(cfm,2);
cfmX=size(cfm,1);
sfmNum=cfmNum;
sfmZ=cfmZ;
sfmY=floor((cfmY-sw)/ss)+1;
sfmX=floor((cfmX-sw)/ss)+1;
sfm=zeros(sfmX,sfmY,sfmZ,sfmNum);
sk_one=ones(sw,sw);
for ii=1:sfmNum
    this_sk=sk_one*sk(ii);
    this_cfm=cfm(:,:,:,ii);
    this_conv=convn(this_cfm,rot90(this_sk,2),'valid');
    s=this_conv(1:ss:end,1:ss:end,1:end);
    sfm(:,:,:,ii)=s+sb(ii);
end
sfm=sigmoid(sfm);
end

