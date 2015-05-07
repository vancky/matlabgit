function [ outdata ] = select_fited_Stars(indata,lowbound)
%Select those well fited stars
% delete those adjust<lowbound
index=indata(:,end)>lowbound;
index=find(index)';
outdata=indata(:,index);
end

