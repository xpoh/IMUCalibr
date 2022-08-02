function k1 = calcScaleX(W,wx1,wx2,wx3,wy1,wy2,wy3,wz1,wz2,wz3)
%CALCSCALEX
%    K1 = CALCSCALEX(W,WX1,WX2,WX3,WY1,WY2,WY3,WZ1,WZ2,WZ3)

%    This function was generated by the Symbolic Math Toolbox version 5.9.
%    03-Feb-2014 00:45:59

t2 = wy1.^2;
t3 = wz1.^2;
t4 = wy2.^2;
t5 = wz3.^2;
t6 = wy3.^2;
t7 = wz2.^2;
t8 = wx1.^2;
t9 = wx2.^2;
t10 = wx3.^2;
t11 = 1.0./W;
t12 = t3.*t4;
t13 = t2.*t5;
t14 = t6.*t7;
t23 = t2.*t7;
t24 = t3.*t6;
t25 = t4.*t5;
t15 = t12+t13+t14-t23-t24-t25;
t16 = 1.0./t15;
t17 = t6.*t7.*t8;
t18 = t2.*t5.*t9;
t19 = t3.*t4.*t10;
t26 = t4.*t5.*t8;
t27 = t3.*t6.*t9;
t28 = t2.*t7.*t10;
t20 = t16.*(t17+t18+t19-t26-t27-t28);
t21 = sqrt(t20);
t22 = t11.*t21;
k1 = t22;
