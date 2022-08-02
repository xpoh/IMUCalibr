function [ data ] = importSTNOFile(filename )
%importNavFile импортирует структуру данных:
%
% struct in_data_t  //Заголовок файла   s=34
% {
%        float            gyro[3];
%        float            period;
% };

PAKET_SIZE = 16;

fid = fopen(filename ,'r');
[~, c] = fread(fid,inf,'16*char');
p = floor(c/PAKET_SIZE);

data.gyro = zeros(p,3);
data.period = zeros(p,1);

fseek(fid, 0, 'bof');

for i=1:p
    w = fread(fid,3,'float32');

    data.gyro(i, 1) = w(1);
    data.gyro(i, 2) = w(2);
    data.gyro(i, 3) = w(3);
    
    data.period(i,:)      = fread(fid,1,'float32');
    if mod(i,floor(p/100))==0
        fprintf('.');
    end
end

x = data.period > 7*1e-3;

data.period = data.period(x) * 1e6;
data.gyro(x,:) = rad2deg(2*asin(data.gyro(x,:)))./data.period(x)*1e6*3600 ;

fprintf('done\n');
fclose(fid);
end
