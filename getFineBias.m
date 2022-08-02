function [z] = getFineBias(za, zb, zc)
    z1 = [za(1), zb(1), zc(1)];
    n1 = norm(z1);

    z2 = [za(2), zb(2), zc(2)];
    n2 = norm(z2);
    
    if n1 < n2 
        z = z1;
    else
        z = z2;
    end
end