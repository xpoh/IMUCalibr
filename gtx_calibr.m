clear all;

load('gtx.mat');

Fs = 320; % Hz
dn = 1/60026.2;
G0 = 9.81574;
K = 1.2;

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

data.acc = [Wxn0, Wyn0, Wzn0] / G0 * K;

save('gtx_data_n.mat', "data");

[ result_ap, result_g1 ] = calibrGTX('gtx_data_p.mat');

[ result_an, result_g2 ] = calibrGTX('gtx_data_n.mat');

