clear ;
%����bias��flat�Ľű���ע�ⲻҪ������У�����Ḳ�����ݡ�
path='E:\Observation data\M67\B\';%
biasfilename=[path 'bias.fit'];
data=fitsread(biasfilename);
save('M67Bbias.mat','data');
flatfilename=[path 'flat-150424.fit'];
data=fitsread(biasfilename);
save('M67Bflat.mat','data');
clear ;
    
    