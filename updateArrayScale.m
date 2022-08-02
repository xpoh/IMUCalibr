function mo = updateArrayScale( w0x,w0y,w0z,wx,wy,wz,model)
    T=model.T;
    mo=model;
    r = eye(3)*sin(deg2rad(45));
    
    w0x = w0x*T/1e6/3600;
    w0y = w0y*T/1e6/3600;
    w0z = w0z*T/1e6/3600;
    wx = wx*T/1e6/3600;
    wy = wy*T/1e6/3600;
    wz = wz*T/1e6/3600;

    w0x=applyGyroModel(w0x,mo.k,mo.z,eye(3),T);
    w0y=applyGyroModel(w0y,mo.k,mo.z,eye(3),T);
    w0z=applyGyroModel(w0z,mo.k,mo.z,eye(3),T);
    wx=applyGyroModel(wx,mo.k,mo.z,eye(3),T);
    wy=applyGyroModel(wy,mo.k,mo.z,eye(3),T);
    wz=applyGyroModel(wz,mo.k,mo.z,eye(3),T);    
    
    wmx=[mean(w0x(:,1)), mean(w0x(:,2)), mean(w0x(:,3))];
    wmy=[mean(w0y(:,1)), mean(w0y(:,2)), mean(w0y(:,3))];
    wmz=[mean(w0z(:,1)), mean(w0z(:,2)), mean(w0z(:,3))];
    
    tetx = qsum(wx,wmx);
    tety = qsum(wy,wmy);
    tetz = qsum(wz,wmz);

    m=[tetx(end,1),tetx(end,2),tetx(end,3);
       tety(end,1),tety(end,2),tety(end,3);
       tetz(end,1),tetz(end,2),tetz(end,3)];
   
   m = sin(deg2rad(m)/2);
   
    for i=1:3
        mm(i,:)=(r^-1*m(:,i))';
        k(i)=norm(mm(i,:));
        mm(i,:) = mm(i,:)/k(i);
    end
    
    mo.m=model.m*m;
    for i=1:3
        mo.m(i,:) = mo.m(i,:)/norm(mo.m(i,:));
    end
end

