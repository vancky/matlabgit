clear ;%数据清洗 For M67数据 
load M67Bdata.mat
%%
picNo=length(allcenter);
cleaned_M67B_data=cell(1,picNo);
%% 数据清洗
lowbound=0.90;xmax=2048;ymax=2048;
%%
for k=1:length(allcenter)
    cleaned_M67B_data{k}=select_fited_Stars(M67B_data{k},lowbound,xmax,ymax);
end

