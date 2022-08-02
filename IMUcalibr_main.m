clear all;
global path;
global roll_angle;

roll_angle = 90;

[fname, path, filterIndex] = uigetfile('*.mat','MultiSelect', 'on');
a=[];
g=[];

if (iscell(fname))
    count=size(fname(1,:));
    data = cell(max(count),1);
    for i=1:count(2)
        str = cell2mat(fname(1,i)); 
        name = strcat(path,str);
        disp(name);
        [result_a,result_g]=calibrIMU(name);
        name = strcat(path,'mod-',str);
        save(name,'result_a', 'result_g');
        fprintf('saved to %s\n',name);
        a=[a;result_a]; 
        g=[g;result_g];
    end
else
    name = strcat(path,fname);
    disp(name);
    [result_a,result_g] = calibrIMU(name);
    name = strcat(path,'mod-',fname);
    save(name,'result_a', 'result_g');
    fprintf('saved to %s\n',name); 
    a=[a;result_a]; 
    g=[g;result_g];
end
    am=mean(a);
    gm=mean(g);
    ininame = strcat(path,fname,'-a.ini');
    saveToIniFile(ininame,am);
    ininame = strcat(path,fname,'-g.ini');
    saveToIniFile(ininame,gm);    

save(strcat(path,'allmod.mat'),'a','g');
fprintf('Ok');

