function [ outdata ] = select_fited_Stars(indata,lowbound,xmax,ymax)
%Select those well fited stars
% delete those adjust<lowbound
indata=sortrows(indata,1);
index=find(indata(:,end)>lowbound...  % how well the fit does
        &indata(:,1)<xmax...            % something may wrong 
        &indata(:,2)<ymax...     
        &indata(:,1)>0&indata(:,2)>0 ... 
        &abs([diff(indata(:,2));3])>2)'; % for some the same one 

%index=indata(:,end)>lowbound;
%index=find(index)';
outdata=indata(index,:);
end

