function oneStar=getoneStar(M,k,x,y,xs,ys)
%to get a star 
%M is the data martric
%k is the nonumber of the stars which you like 
%x is the vector store the x coordinates of leftup points
%y is the vector store the y coordinates of leftup points
%xs is the vector store the x span of a star
%ys is the vector store the y span of a star
if k>length(x)||length(x)~=length(y)
    error('no enlough stars or wrong points');
    oneStar=0;
else
   [lineM,rankM]=size(M);
    oneStar=M(x(k):min(x(k)+2*xs(k),lineM),y(k):min(y(k)+2*ys(k),rankM));
end
end