clear ;
%计算bias和flat的脚本，注意不要随便运行，否则会覆盖数据。
path='E:\Observation data\M67\B\';%
biasfilename=[path 'bias.fit'];
bias_data=fitsread(biasfilename);
save('M67Bbias.mat','bias_data');
flatfilename=[path 'flat-150424.fit'];
flat_data=fitsread(flatfilename);
save('M67Bflat.mat','flat_data');
    
    