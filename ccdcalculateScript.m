%% Script to calculate a fits image
%read data
clear ;
data=fitsread('pMC067150424B0001.fit');
 %% raw image  original picture
 figure('Name','original picture');
 imshow(data, []); 
 %minVal = min(min(data));
 %maxVal = max(max(data));
 %normalData = ( data - minVal ) ./ ( maxVal - minVal );
%normalData=mat2gray(data,[0,10000]);
 normalData=data;
 %% normalized image    
  figure('Name','normalized image');
 imshow(normalData,[]);
 
 %% image openning
 se1 = strel('disk', 10);%构造一个圆盘形状的20×20大小的元素 
 openData = imopen(normalData, se1);%进行开操作
 diffData=normalData-openData;
   figure('Name','diff image')
  imshow(diffData);
backgroundthreshold= mean(median(normalData(500:1500,500:1500)))...
    +30*std(median(normalData(500:1500,500:1500)));%阈值就是先取中位数再平均
asteroid=normalData>backgroundthreshold;
%asteroid=diffData>backgroundthreshold;
  figure('Name','indicator image');
 imshow(asteroid);

 %%  clean the picture 
 %去掉小的像素块，小于3×3的星象一律删除。
 se2=strel('disk',3);
 ep_asteroid=imopen(asteroid,se2);
 figure('Name','cleanned picture');
 imshow(ep_asteroid);
  %imshow(bwperim(ep_asteroid));
 %% find the centeral points
 tmpData = bwmorph(ep_asteroid, 'thicken');%边界加粗
 centerData = bwmorph(tmpData,'shrink',Inf);%图像收缩至一点
 figure('Name','centeral points');
 imshow(centerData);
%% get the star's position
[x,y]=find(centerData);
M=ep_asteroid;
[lineM,rankM]=size(M);
i=zeros(1,length(x));
j=i;
for k=1:length(x)
    while M(x(k),y(k)+i(k))&&y(k)+i(k)<rankM
        i(k)=i(k)+1;
    end
    while M(x(k)+j(k),y(k))&&x(k)+j(k)<lineM
        j(k)=j(k)+1;
    end
end
i=i';j=j';
leftuppointX=max(1,x-(i+4));%x coordinate of left up point 
leftuppointY=max(1,y-(j+4));%y coordinat of left up point 
spanX=i+4;%x span of a star
spanY=j+4;%y span of a star
%to use the stars like this 
 %firstStar=data(leftuppointX(1):min(leftuppointX(1)+2*spanX(1),size(data)),leftuppointY(1):min(leftuppointY(1)+2*spanY(1),size(data)));
  %% get  one star 
  % if you want all stars, use the next sentence,be careful to change 5
  % into k and delete the starnumber 
 for k=1:100
 %k=15;
 fStar=getoneStar(data,k,leftuppointX,leftuppointY,spanX,spanY);
 % to see the star you find  if you don't like just note it 
figure('Name','One star')
 surf(fStar);




 % to calculate a star's info about exact position and so on
% ('starNO.',k,'B',res.b,'S_sum',S_sum,'x0',res.x0,'y0',res.y0,'Rx',res.sigmax,'Ry',res.sigmay, sse,rsquare,dfe,adjrsquare,rmse);
[rankS,lineS]=size(fStar);
[yi,xi]=meshgrid(1:lineS,1:rankS);
%res(x,y) = a*exp(-((x-x0).^2/2/sigmax^2 + (y-y0).^2/2/sigmay^2)) + b
%startpoint= a ,b ,sigmax ,sigmay ,x0,y0
startpoint=[max(max(fStar))/2 min(min(fStar)) rankS/4 lineS/4 rankS/2 lineS/2];
[res, gof]=createFit(xi,yi,fStar,startpoint,1);
S_sum=res.a*2*pi*res.sigmax*res.sigmay;
% ('B',res.b,'S_sum',S_sum,'x0',res.x0,'y0',res.y0,'Rx',res.sigmax,'Ry',res.sigmay, sse,rsquare,dfe,adjrsquare,rmse);
starinfo=[k,res.b,S_sum,leftuppointX(k)+res.x0,leftuppointY(k)+res.y0,res.sigmax,res.sigmay,gof.sse,gof.rsquare,gof.dfe,gof.adjrsquare,gof.rmse];
starinfo_strcuture=struct('B',res.b,'S_sum',S_sum,'x0',leftuppointX(k)+res.x0,'y0',leftuppointY(k)+res.y0,'Rx',res.sigmax,'Ry',...
res.sigmay, 'sse',gof.sse,'rsquare',gof.rsquare,'dfe',gof.dfe,'adjrsquare',gof.adjrsquare,'rmse',gof.rmse);
%disp fits info like this
 
 res
 gof
 starinfo_strcuture
 pause;
 % the last end is ready for all stars with  for loops
 end
 