function [ res ] = calibrGyroGtx( data )
    n = data.n;
    res = zeros(n,15);
    fprintf('calibrate gyro');
    res = [];
    for i=1:n
        res = [res; getGyroModelGtx(data.calibr{i,1}.data)];
        fprintf('.');
    end
    fprintf('\n');
end

