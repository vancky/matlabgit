%% fits�ļ�����ű�������һ�ξ�ok��
%% �����ļ�·�����ʼ��
clear ;
path='E:\Observation data\M67\B\';
picNo=72;
M67B_data=cell(1,picNo);
allcenter=zeros(picNo,2);
allseeing=zeros(picNo,1);
allfn=cell(1,picNo);
%% ����
tic
for k=1:picNo 
    filename=[path,'pMC067150424B0',sprintf('%03d',k),'.fit'];
    tmpinfo=fitsinfo(filename);
    allseeing(k)=tmpinfo.PrimaryData.Keywords{34,2};
    allfn{k}=filename;
    allcenter(k,1)=tmpinfo.PrimaryData.Keywords{41,2}*180/pi;
    allcenter(k,2)=tmpinfo.PrimaryData.Keywords{42,2}*180/pi;
    tmpdata=fitsread(filename);
    M67B_data{k}=ccd_Calculate_For_M67(tmpdata); 
    fprintf('�Ѿ���ɵ�%d�ŵ�Ƭ,�ܹ�%d�ŵ�Ƭ\n',k,picNo);
end
%%
toc
