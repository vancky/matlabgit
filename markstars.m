figure('name','ÕÒµ½µÄÐÇ');
imshow(ep_asteroid,[]);
hold on;
%% 
for k=1:72
%k=9;
   
    plot(stars(k,5),stars(k,4),'o','markersize',3*min(stars(k,5:6)));
end
hold off;
%% 
 figure;hold on;axis([0 700 0 100]);
for k=1:72
    tmpdata=cleaned_M67B_data{k};
    tmpdata=diff(tmpdata(:,2));
    plot(abs(tmpdata),'.');
   % fprintf('%d\n',k);
  %  pause;
end
