function [out] = ApplyGtxModel(data, a0, g0, Fs)

    a.w = a0(1:3, 2)';
    a.m = a0(1:3, 3:5);

    g.w = g0(1:3, 2)';
    g.m = g0(1:3, 3:5);
    
    out = data;

    parfor i=1:length(data.acc)
        acc(i,:) = data.acc(i,:);
        acc(i,:) = acc(i,:) - a.w;
        acc(i,:) = acc(i,:) * a.m;  
        
        gyro(i,:) = (g.m * data.gyro(i,:)')';
        gyro(i,:) = gyro(i,:) - g.w;
    end
    out.acc = acc;
    out.gyro = gyro;

    [q1, q2] = butter(2, 1/Fs/100);
    out.gyrof = filter(q1, q2, out.gyro);

    [q1, q2] = butter(2, 1/Fs/10);
    out.accf = filter(q1, q2, out.acc);
end

