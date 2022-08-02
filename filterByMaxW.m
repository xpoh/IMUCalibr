function [ y, W] = filterByMaxW( w, n )
% function [ y, W] = filterByMaxW( w, n, sensStatus )
    N=length(w);
%         for k=1:3
%             x=find(bitand(sensStatus,2.^(8+k))>0);
%             w(x,k)=w(x-1,k);
%             w(x+1,k)=w(x-1,k);
%             w(x+2,k)=w(x-1,k);
%         end
       
    for i=1:n
        for k=1:3
            dw=diff(w(:,k));
            x=find(abs(dw)>2000);
            t=x+1;
            w(t,k)=0;
        end
    end
    
    y=w;
    i=1:N;
    W(i,1) = sqrt(w(i,1).^2+w(i,2).^2+w(i,3).^2);


