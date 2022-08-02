function [ res ] = calibrAccGtx( data )
    global alf;    
    global path;
    
    alname = strcat(path,'align.txt');
    if exist(alname)>0
        [alf] = textread(alname,'%f');
    else 
        [alf] = [0;0];
    end    
    fprintf('Align x=%f,\ty=%f (from align.txt)\n', alf);
  
    n = data.n;
    res = zeros(n,15);
        
    fprintf(' calibrate acc');
    res = [];
    for i=1:n
        res = [res; getAccModelGtx(data.calibr{i,1}.data)];
    end
    fprintf('\n');
end

