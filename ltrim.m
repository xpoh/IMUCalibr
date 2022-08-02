function [ out ] = ltrim( in, n )
    out.count = in.count(n:end,:);
    out.acc = in.acc(n:end,:);
    out.accCount = in.accCount(n:end,:);
    out.gyro = in.gyro(n:end,:);
    out.period = in.period(n:end,:);
    out.sensStatus = in.sensStatus(n:end,:);
    out.mux = in.mux(floor(n/32):end,:);
    out.crc = in.crc(n:end,:);
    

