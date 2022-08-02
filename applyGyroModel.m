function [ wo ] = applyGyroModel( w,k,z,m,T )
    n = length(w);
    t=1:n;
    wo=zeros(n,3);

    for i=1:3
        wo(:,i)=w(:,i)./k(i);
    end    
    
    wo(t,:)=(m*wo(t,:)')';
  
    for i=1:3
        wo(:,i)=wo(:,i) - z(i)*T/1e6/3600;
    end
end

