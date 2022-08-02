function [err] = fullVectorError(z, w)
    W = 15.041;
    
    err1 = abs(sqrt((w(1)-z(1))^2+(w(2)-z(2)).^2+(w(3)-z(3)).^2) - W);
    err2 = abs(sqrt((w(4)-z(1))^2+(w(5)-z(2)).^2+(w(6)-z(3)).^2) - W);
    err3 = abs(sqrt((w(7)-z(1))^2+(w(8)-z(2)).^2+(w(9)-z(3)).^2) - W);
    
    err = err1 + err2 + err3;    
end

