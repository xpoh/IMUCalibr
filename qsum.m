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

function [sumw, a] = qsum(w,E)
    sumq = angle2quat(0,0,0);
    sumq1 = angle2quat(0,0,0);
    sumw = zeros(length(w),3);
    sumw1 = zeros(length(w),3);

    a = zeros(length(w),1);
    
    e = deg2rad(E);
    N = norm(e);

    e1 = [cos(N/2), e./N.*sin(N/2)];
    e1 = quatconj(e1);
    
    e = [1, sin(deg2rad(E(1))/2),...
        sin(deg2rad(E(2))/2),...
        sin(deg2rad(E(3))/2)];
    
    e = quatconj(e);

    for i=1:length(w)
        t = [1, sin(deg2rad(w(i,1))/2),...
            sin(deg2rad(w(i,2))/2),...
            sin(deg2rad(w(i,3))/2)];

        sumq = quatmultiply(e, sumq);
        sumq = quatmultiply(sumq, t);
        sumq = quatnormalize(sumq);
        
        w1 = deg2rad(w(i,:));
        W = norm(w1);
        t1 =  [cos(W/2), w1./W.*sin(W/2)];
        sumq1 = quatmultiply(e1, sumq1);
        sumq1 = quatmultiply(sumq1, t1);
        sumq1 = quatnormalize(sumq1);
                
%         sumw(i,1:3) = rad2deg(quat2eul(sumq,"XYZ"));
%         sumw1(i,1:3) = rad2deg(quat2eul(sumq1,"XYZ"));
        sumw(i,1:3) = 2*rad2deg(asin(sumq(2:4)));
        sumw1(i,1:3) = 2*rad2deg(asin(sumq1(2:4)));
        a(i,1) = 2*rad2deg(acos(sumq(1)));
    end
end