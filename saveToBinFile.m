function saveToBinFile(filename, m)
    f = fopen(filename ,'w');
    
    for i=1:3
        for j=1:3
            fwrite(f, m.m(i,j), 'double');
        end
    end
    
    fclose(f);

    f = fopen(filename+"_r" ,'w');
    [q, r] = qr(m.m)
    
    for i=1:3
        for j=1:3
            fwrite(f, r(i,j), 'double');
        end
    end
    
    fclose(f);

end
