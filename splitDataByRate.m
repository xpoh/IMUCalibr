
function [ out ] = splitDataByRate( in, wf )
% splitDataByRate - функция разделяет данные на интервалы покоя и вращения
    load('filter.mat');
    
    Wmax = 1600; %deg/h
    Wh   = 50;
    [gyro, W] = filterByMaxW(wf, 5);
    
    N=length(in.gyro);
    
    x1=find(W<Wmax);
    x2=find(W>Wmax);
    dx1=diff(x1);
    dx2=diff(x2);    
    xx1= dx1>20;
    xx2= dx2>20;
    x1=x1(xx1);
    x2=x2(xx2);
    x=[x1;x2];
    x=sort(x);
    x=[1;x;N];
    n=length(x)-1;
    i1=1:2:n;
    x(i1)=x(i1)+Wh;
    i2=2:2:n;
    x(i2)=x(i2)-Wh;
    out.data=cell(n,1);
    out.n = n;
    
    for i=1:n
        t=x(i):x(i+1);
        out.data{i,1}.acc=in.acc(t,:);
        out.data{i,1}.gyro=in.gyro(t,:);
        out.data{i,1}.period=in.period(t,:);
    end
end

