function [q_out] = norma_q(q)
% void norma_q(double* q, int size)
% {
%     double s;
%     s = 0;
%     for (int i = 0; i < size; i++)
%         s += q[i] * q[i];
%     s = sqrt(s);
%     if (s)
%         for (int i = 0; i < size; i++)
%             q[i] /= s;
% }

s = q(1)*q(1)+q(2)*q(2)+q(3)*q(3)+q(4)*q(4);
    s = sqrt(s);
    q_out = q./s;
end

