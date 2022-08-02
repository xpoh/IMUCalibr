clear all;

global roll_angle;

roll_angle = 60;

load('ech1.mat');

plot(data.gyro);

g_data{1,1}.gyro = data.gyro(5910:203920,:);   % Выставка 0
g_data{7,1}.gyro = data.gyro(371303:501545,:); % Выставка на 90
g_data{13,1}.gyro = data.gyro(547790:744795,:);% Выставка 180

g_data{2,1}.gyro = data.gyro(208107:217958,:); % Поворот вокруг x
g_data{6,1}.gyro = data.gyro(360799:366850,:); % Поворот вокруг y
g_data{8,1}.gyro = data.gyro(505767:513252,:); % Поворот вокруг z
g_data{1,1}.period = mean(data.period);

[res, f] = getGyroModel(g_data);
saveToIniFile('ech11.ini', res);