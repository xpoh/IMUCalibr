function mo = updateArrayGtx( w0x,w0y,w0z,wx,wy,wz,model)
    global roll_angle;

    % TODO вынести на интерфейс

    mo=model;
    alf_x=-90;
    alf_y=-90;
    alf_z=90;
    
%     Сырые данные: w0x,y,z - участок выставки,
%                   wx,y,z - поворот вкруг x,y,z соот.
    
    w0x_t = w0x.gyro.*w0x.period/1e6/3600;
    w0y_t = w0y.gyro.*w0y.period/1e6/3600;
    w0z_t = w0z.gyro.*w0z.period/1e6/3600;
    wx_t = wx.gyro.*wx.period/1e6/3600;
    wy_t = wy.gyro.*wy.period/1e6/3600;
    wz_t = wz.gyro.*wz.period/1e6/3600;
    
    w0x=applyGyroModel(w0x_t,mo.k,mo.z,mo.m,mean(w0x.period));
    w0y=applyGyroModel(w0y_t,mo.k,mo.z,mo.m,mean(w0y.period));
    w0z=applyGyroModel(w0z_t,mo.k,mo.z,mo.m,mean(w0z.period));
    
    wx=applyGyroModel(wx_t,mo.k,mo.z,mo.m,mean(wx.period));
    wy=applyGyroModel(wy_t,mo.k,mo.z,mo.m,mean(wy.period));
    wz=applyGyroModel(wz_t,mo.k,mo.z,mo.m,mean(wz.period));    
    
    wmx=[mean(w0x(:,1)), mean(w0x(:,2)), mean(w0x(:,3))];
    wmy=[mean(w0y(:,1)), mean(w0y(:,2)), mean(w0y(:,3))];
    wmz=[mean(w0z(:,1)), mean(w0z(:,2)), mean(w0z(:,3))];
    
%   Интегрирование поворота с вычетом земли
    [tetx,ax] = qsum(wx,wmx); % Не перепутано, подумай...
    [tety,ay] = qsum(wy,wmy); % Не перепутано, подумай...
    [tetz,az] = qsum(wz,wmx); % Не перепутано, подумай...
        
%   матрица поворотов в град
    m=[tetx(end,1),tetx(end,2),tetx(end,3);
       tety(end,1),tety(end,2),tety(end,3);
       tetz(end,1),tetz(end,2),tetz(end,3)];

    m = m';
    
    disp(m);

%    матрица векторной части кватерниона
    m = sin(deg2rad(m/2));
    
%   матрица идеальной векторной части кватерниона (все повороты на 90 град) 
%                       - если оси блока приведены к осям стола 
    e = eye(3);
    e(1,1) = sin(deg2rad(alf_x/2));
    e(2,2) = sin(deg2rad(alf_y/2));
    e(3,3) = sin(deg2rad(alf_z/2));
    
%   Ошибка несовпадения осей
    err = abs(e-m);

%   Матрица приведения
    m = e*(m^-1);
    
%   Уточняем итоговую матрицу
    m=m*mo.m; 
    
    k=ones(1,3);
    
    %   Считаем МК как норму столбца матрицы
%     for i=1:3
%         k(i)=1/norm(m(:,i));
%         m(:,i) = m(:,i)*k(i);
%     end
%     
%     mo.k=mo.k.*k;
    mo.m=m;
    
end

