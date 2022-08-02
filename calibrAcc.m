function [ res ] = calibrAcc( data )
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
    for i=1:n
        res(i,:) = getAccModel(data.calibr{i,1}.data);
        fprintf('.');
    end
    fprintf('\n');
end

