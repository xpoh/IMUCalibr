function [ model ] = calcOrient( rot_x, rot_y, rot_z, angels )
    det_array=[sin(deg2rad(angels(1))/2),0,0;
               0,sin(deg2rad(angels(2))/2),0;
               0,0,sin(deg2rad(angels(3))/2)];
    
    a(1,:)=sin(deg2rad(rot_x)/2);
    a(2,:)=sin(deg2rad(rot_y)/2);
    a(3,:)=sin(deg2rad(rot_z)/2);
    
    model.k=[1,1,1];

    D = det(det_array);

    if D==0 
        return;
    end
    
    for i=1:3
        for j=1:3
            matr = det_array;
            matr(:,j)=a(:,i);
            model.m(i,j)=det(matr)/D;
        end
    end
%     model.m=model.m*det_array;
    
    for i=1:3
       model.k(i) = norm(model.m(:,i));
       model.m(:,i)=model.m(:,i)./model.k(i);
    end

    model.m=model.m^-1;

    for i=1:3
       model.m(:,i)=model.m(:,i)./norm(model.m(:,i));
    end
    

end

