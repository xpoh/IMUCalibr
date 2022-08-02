function saveToIniFile(filename, m)
    f = fopen(filename ,'w');

    fprintf(f,'[scale]\n');
    for i=1:3
        fprintf(f,'scale%d=%12.12f\n',i-1,m(i));    
    end
    fprintf(f,'[drift]\n');
    for i=1:3
        fprintf(f,'drift%d=%12.12f\n',i-1,m(i+3));    
    end
    fprintf(f,'[matrix]\n');
    for i=1:3
    for j=1:3
        fprintf(f,'matrix%d%d=%12.12f\n',i-1,j-1,m(6+(j-1)*3+i));       
    end
    end
    fclose(f);
end
