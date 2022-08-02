function [res] = getAccModelGtx( data )
    global alf;
    global roll_angle;
    roll_angle = 90;
    calf = roll_angle;
    
    alfx=deg2rad(alf(1,1)/3600);
    alfy=deg2rad(alf(2,1)/3600);
    
    g0=[alfx, alfy, 1];
    g1=quatrotate([cos(deg2rad(calf/2)), -sin(deg2rad(calf/2)), 0,0],g0);
    g2=quatrotate([cos(deg2rad(calf/2)), 0, 0, sin(deg2rad(calf/2))],g1);
    g3=quatrotate([cos(deg2rad(calf/2)), 0, 0, sin(deg2rad(calf/2))],g2);
    
    G0 = [[g0,1];[g1,1];[g2,1];[g3,1]];
    
    Ax=ones(4,4);
    for i=1:3
        Ax(1,i) = mean(data{1,1}.acc(:,i));
        Ax(2,i) = mean(data{3,1}.acc(:,i));
        Ax(3,i) = mean(data{5,1}.acc(:,i));
        Ax(4,i) = mean(data{7,1}.acc(:,i));
    end

    for i=1:3
        MW(:,i) = G0^-1*Ax(:,i);
        S(i)=1; %norm(MW(1:3,i));
        MW(1:3,i)=MW(1:3,i)/S(i);
    end

    M=MW(1:3,1:3);
    M=M^-1;
    D=MW(4,:);
    D=D./S(i);
    [q,r] = qr(M);
    res=[S',D',M, q, r];
end

