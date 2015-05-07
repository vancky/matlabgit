function stars=ccd_Calculate_For_M67(data)
%-----------------------------------------------------------
% input: orginal data
% output: all stars in the ccd
% every rank is a star's info 
% from left to right
% starnumber,b,S_sum,x0,y0,Rx,Ry, sse,rsquare,dfe,adjrsquare,rmse 
% the last five parameters are for gaussian fit 
% writen by lifan 2013/4/13 22:04
%--------------------------------------------------------------
 % raw image  original picture
 %update by lifan@2013/7/30
 %add backgroundthreshold  add column 22  and change column 29---》30
 %update by lifan@2014/04/03 to use for NGC1664 
 %update for NGC1664 YFOSC 
 %update for M67
normalData=data;%mat2gray(data,[0,10000]);
% image openning
%se1 = strel('disk', 5);%构造一个圆盘形状的20×20大小的元素 
%openData = imopen(normalData, se1);%进行开操作
%diffData=normalData-openData;
backgroundthreshold= mean(median(normalData(500:1500,500:1500)))...
    +10*std(median(normalData(500:1500,500:1500)));%阈值就是先取中位数再平均
asteroid=normalData>backgroundthreshold;
% clean the picture 
se2=strel('disk',3);
ep_asteroid=imopen(asteroid,se2);
% find the centeral points
tmpData=bwmorph(ep_asteroid,'thicken');%边界加粗
centerData = bwmorph(tmpData,'shrink',Inf);%图像收缩至一点
% get the star's position
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
%x coordinate of left up point 
leftuppointX=max(x-(i+4),1);% 2是为了不丢失太多信息，此处可以改
%y coordinat of left up point 
leftuppointY=max(y-(j+4),1);% 同上
%x span of a star
spanX=i+4;%保留更多信息
%y span of a star
spanY=j+4;%同上
%create a matric to return
 stars=zeros(length(x),4);
%get all stars
 for k=1:length(x)
 fStar=getoneStar(data,k,leftuppointX,leftuppointY,spanX,spanY);
[rankS,lineS]=size(fStar);
[yi,xi]=meshgrid(1:lineS,1:rankS);
%gauss(x,y)= a*exp(-((x-x0).^2/2/sigmax^2 + (y-y0).^2/2/sigmay^2)) + b
%startpoint= a ,b ,sigmax ,sigmay ,x0,y0

% fit gaussian function 
startpoint=[max(max(fStar))/2 min(min(fStar)) rankS/4 lineS/4 rankS/2 lineS/2];
[res, gof]=createFit(xi,yi,fStar,startpoint,0);  
% get the S_sum 
S_sum=res.a*2*pi*res.sigmax*res.sigmay; 
% the structure of a star is just like the next sentence
% starnumber,b,S_sum,x0,y0,Rx,Ry,sse,rsquare,dfe,adjrsquare,rmse 
%stars(k,:)=[k,res.b,S_sum,leftuppointX(k)+res.x0,leftuppointY(k)+res.y0,res.sigmax,res.sigmay,gof.sse,gof.rsquare,gof.dfe,gof.adjrsquare,gof.rmse];
stars(k,:)=[leftuppointY(k)+res.y0,leftuppointX(k)+res.x0,S_sum,gof.adjrsquare];%注意这里换了x,y
 end
end