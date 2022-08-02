function [ rw ] = getRW( data, period )
    n = length(data);
    f = int64(1e6/period*100);
    n = int64(floor(n/f))*f;
    for i=1:3
        w = data(1:n,i);
        w = reshape(w,int64(n/f),int64(f));
        w = (sum(w')./double(f))';
        rw(i) = std(w);
    end
end

