function [res, f, m] = getGyroModelGtx( data )
    N=10;
    N1=10;

    m.k=[1,1,1]; m.z=[0,0,0]; 

    m.m=eye(3);
%     m.m = -[[-0.3, -0.5, 0.8]; [-0.8, 0.65, 0.1]; [0.56, 0.56, 0.56]];

    w0x=data{1,1}; % Выставка 0
    w0y=data{7,1}; % Выставка на 90
    w0z=data{13,1};% Выставка 180

    wx=data{2,1};  % Поворот вокруг x
    wy=data{8,1};  % Поворот вокруг y
    wz=data{6,1};  % Поворот вокруг z
    
    m.T = mean(data{1,1}.period);
    for j=1:N
       fprintf("Step %d:\n", j); 
       m=updateArrayGtx(w0x,w0y,w0z,wx,wy,wz,m);
       f(j,:)=[m.k,m.z, m.m(1,:), m.m(2,:), m.m(3,:)];
    end
    
    for j=N+1:N+N1+1
       fprintf("Step %d:\n", j); 
       m=updateGyroBias(w0x.gyro,w0y.gyro,w0z.gyro,m);
       m=updateArrayGtx(w0x,w0y,w0z,wx,wy,wz,m);
       f(j,:)=[m.k,m.z, m.m(1,:), m.m(2,:), m.m(3,:)];
    end

[m.q, m.r] = qr(m.m);

m.a = [m.k', m.z',m.m, m.q, m.r];
res = m.a;

