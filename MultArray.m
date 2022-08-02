function [v] = MultArray(m, b)
% void MultArray(double arr[3][3], double *b)
% {
%     double g[3];
%     for (int i=0;i<3;i++)
%     {
%         g[i]=0;
%         for (int j=0;j<3;j++)
%             g[i]+=arr[i][j]*b[j];
%     }
%     for (int i=0;i<3;i++) b[i]=g[i];
% }
    v = zeros(1,3);
    for i=1:3
        for j=1:3
            v(i) = v(i) + m(j,i)*b(j);    
        end
    end
end

