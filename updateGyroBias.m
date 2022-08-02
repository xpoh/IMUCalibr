function mo=updateGyroBias(wx,wy,wz,m)
    W=15.041;    
    mo=m;
   
    r = mo.m;

    w1 = mean(wx)./mo.k;
    w2 = mean(wy)./mo.k;
    w3 = mean(wz)./mo.k;
    
    w1 = (r * w1')';
    w2 = (r * w2')';
    w3 = (r * w3')';

    w1 = w1 - mo.z;
    w2 = w2 - mo.z;
    w3 = w3 - mo.z;

    disp(sqrt(w1(1)^2+w1(2)^2+w1(3)^2));
    disp(sqrt(w2(1)^2+w2(2)^2+w2(3)^2));
    disp(sqrt(w3(1)^2+w3(2)^2+w3(3)^2));
     
    za=getDriftX(W,w1(1),w2(1),w3(1),w1(2),w2(2),w3(2),w1(3),w2(3),w3(3));
    zb=getDriftY(W,w1(1),w2(1),w3(1),w1(2),w2(2),w3(2),w1(3),w2(3),w3(3));
    zc=getDriftZ(W,w1(1),w2(1),w3(1),w1(2),w2(2),w3(2),w1(3),w2(3),w3(3));
    
    [z] = getFineBias(za, zb, zc);

    mo.z=mo.z + z;
end

