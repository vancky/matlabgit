%% fits文件计算脚本，运行一次就ok了
%% 设置文件路径与初始化
clear ;
path='E:\Observation data\M67\B\';
picNo=72;
M67B_data=cell(1,picNo);
allcenter=zeros(picNo,2);
allseeing=zeros(picNo,1);
allfn=cell(1,picNo);
%% 计算
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
    fprintf('已经完成第%d张底片,总共%d张底片\n',k,picNo);
end
%%
toc
