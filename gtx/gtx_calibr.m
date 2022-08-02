clear;

load('gtx.mat');

Fs = 320; % Hz
dn = 1/60026.2;
G0 = 9.81574;   % Zelenograd place
K = 1.2;        % Nominal scale value

Wxp0 = -9.81*(txt.Wxp0-1600)/800; % [m/s2]
Wyp0 = +9.81*(txt.Wyp0-1600)/800; % [m/s2]
Wzp0 = +9.81*(txt.Wzp0-1600)/800; % [m/s2]

Wxn0 = -9.81*(txt.Wxn0-1600)/800; % [m/s2]
Wyn0 = +9.81*(txt.Wyn0-1600)/800; % [m/s2]
Wzn0 = +9.81*(txt.Wzn0-1600)/800; % [m/s2]

data.acc = [Wxp0, Wyp0, Wzp0] / G0 * K;
data.gyro = [txt.fog_rx0, txt.fog_ry0, txt.fog_rz0];
data.period = ones(length(data.gyro),1)/Fs*1e6; 

save('gtx_data_p.mat', "data");
data_p = data;

data.acc = [Wxn0, Wyn0, Wzn0] / G0 * K;

save('gtx_data_n.mat', "data");
data_n = data;

[ result_ap, result_g1 ] = calibrGTX('gtx_data_p.mat');

[ result_an, result_g2 ] = calibrGTX('gtx_data_n.mat');

ap = result_ap;
an = result_an;
g = result_g2;

data_p1 = ApplyGtxModel(data_p, ap, g, Fs);
data_n1 = ApplyGtxModel(data_n, an, g, Fs);

plot(sqrt(data_p1.gyrof(:,1).^2+data_p1.gyrof(:,2).^2+data_p1.gyrof(:,3).^2));
figure;
plot(sqrt(data_p1.accf(:,1).^2+data_p1.accf(:,2).^2+data_p1.accf(:,3).^2));


