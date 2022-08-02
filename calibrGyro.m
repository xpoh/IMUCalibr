function [ res ] = calibrGyro( data )
    n = data.n;
    res = zeros(n,15);
    fprintf('calibrate gyro');
    for i=1:n
        res(i,:) = getGyroModel(data.calibr{i,1}.data);
        fprintf('.');
    end
    fprintf('\n');
end

