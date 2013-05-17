function [ fm1,fm2] = classifier( sfm,k1,b1,k2,b2)
%������ͼ����BP�㷨
%sfm ��������� (4D)
%k1  ��һ���Ȩֵ  (5D)
%b1  ��һ���ƫ��ֵ (1D)
%k2  �ڶ����Ȩֵ   (2D)
%b2  �ڶ����ƫ��ֵ  (1D)
outNum=size(k1,5);
outNum2=size(k1,4);
%���ز�
fm1=zeros(1,outNum);
for ii=1:outNum
    this_k=k1(:,:,:,:,ii);
    for jj=1:outNum2
        this_sfm=sfm(:,:,:,jj);
        this_kernel=this_k(:,:,:,jj);
        this_conv=conv3(this_sfm,this_kernel,'valid');
        fm1(ii)=fm1(ii)+this_conv;
    end
    fm1(ii)=fm1(ii)+b1(ii);
end
fm1=sigmoid(fm1);
%�����
fm2=fm1*k2;
fm2=fm2+b2;
fm2=sigmoid(fm2);
end

