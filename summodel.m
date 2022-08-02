clear all;

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
        load(name);
        a=[a;result_a];
        g=[g;result_g];
    end
end
fprintf('Ok');

