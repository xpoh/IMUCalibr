function [q_out] = inverse_q(q)
% void inverse_q(double *q)
% {
%     for (int j=0;j<3;j++) q[j+1]=-q[j+1];
% }
q_out(1) = q(1);
q_out(2) = -q(2);
q_out(3) = -q(3);
q_out(4) = -q(4);
end

