function [ result_a, result_g ] = calibrGTX( filename )
    Nca=8;%  оличество состо€ний дл€ 1 калибровки аксов
    Ncg=14;%  оличество состо€ний дл€ 1 калибровки гироскопов

    load(filename);

    [b,a]=butter(2,0.1);
        for i=1:3
            x=find(abs(diff(data.gyro(:,i)))>10000);
            data.gyro(x-1,i)=0;
            data.gyro(x,i)=0;
            data.gyro(x+1,i)=0;    
            if x>0
                fprintf('Errors %d\n',x);
            end
        end
    
    wf = filtfilt(b,a, data.gyro);
    data2 = splitDataByRate(data,wf);
        
    N = floor(data2.n/(Nca+Ncg));

    a_data.calibr=cell(N,1);
    a_data.n=N;
    g_data.calibr=cell(N,1);
    g_data.n=N;

    fprintf('    split data');
    for i=1:N    
        for j=1:Nca
            a_data.calibr{i}.data{j,1}=data2.data{(i-1)*(Nca+Ncg)+j,1};
        end
        for j=1:Ncg
            g_data.calibr{i}.data{j,1}=data2.data{(i-1)*(Nca+Ncg)+j+Nca,1};    
        end 

        fprintf('.');
    end
    fprintf('\n');
    
    result_a = calibrAccGtx(a_data);
    result_g = calibrGyroGtx(g_data);
end

