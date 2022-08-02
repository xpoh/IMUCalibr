function [sumw, a] = qsum_rare(w,E)
% Функция проводит вычисление ориентации путем интегрирования приращений
% углов.
% Выходные параметры:
% sumw - матрица ориентации в трех осях, град, столбцы матрицы
% соответствуют проекциям углов.
% a - полный угол ориентации
%
% Входные:
% w - приращения углов (проекции на три оси - три столбца), град
% E - компоненты угловой скорости земли - на те же оси, град (за такт)

sumq = angle2quat(0,0,0);
sumw = zeros(length(w),3);
a = zeros(length(w),1);

e = [1, sin(deg2rad(E(1))/2),...
    sin(deg2rad(E(2))/2),...
    sin(deg2rad(E(3))/2)];

e = real(e);
e = quatconj(e);

for i=1:length(w)
    qDelta = [1, sin(deg2rad(w(i,1))/2),...
        sin(deg2rad(w(i,2))/2),...
        sin(deg2rad(w(i,3))/2)];
    
    sumq = mult_q2(sumq, qDelta);
    
    l0=sumq(1);
    l1=-sumq(2);
    l2=-sumq(3);
    l3=-sumq(4);
    
    d_fi(1) = 1;
    
    d_fi(2)=(l0*l0+l1*l1-l2*l2-l3*l3)*e(2)...
        +2.*(l1*l2-l0*l3)*e(3)...
        +2.*(l1*l3+l0*l2)*e(4);
    
    d_fi(3)=(l0*l0+l2*l2-l1*l1-l3*l3)*e(3)...
        +2.*(l1*l2+l0*l3)*e(2)...
        +2.*(l2*l3-l0*l1)*e(4);
    
    d_fi(4)=(l0*l0+l3*l3-l1*l1-l2*l2)*e(4)...
        +2.*(l1*l3-l0*l2)*e(2)...
        +2.*(l2*l3+l0*l1)*e(3);
    
    sumq = mult_q2(sumq, d_fi);
    sumq = norma_q(sumq);
    
%         sumw(i,1:3) = rad2deg(quat2eul(sumq, "XYZ"));
%     sumw(i,1:3) = 2*rad2deg(asin(sumq(2:4)));
    a(i,1) = 2*rad2deg(acos(sumq(1)));
    
    ww = sumq(1);
    x = sumq(2);
    y = sumq(3);
    z = sumq(4);
    
    test = (ww * x + y * z) * 2;
    
    sqx = x * x;
    sqy = y * y;
    sqz = z * z;
    
    h = atan2(ww * z - x * y, 0.5 - sqz - sqx);
    a = asin(test);
    b = atan2(ww * y - x * z, 0.5 - sqy - sqx);
%     
%     if (h < 0)
%         h = h + pi/2;
%     end
%     if (a < 0)
%         a = a + pi/2;
%     end
%     if (b < 0)
%         b = b + pi/2;
%     end
    sumw(i,1:3) = rad2deg([a, b, h]);
end