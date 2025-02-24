n = 10;
k1 = 0.8+3 /(n^2+1);
k2 = 0.01*(5+3/(n+1));
a = 0.6 + (5/ (n^2+7));
epsilon = 0.01 + 3/ (n^2+1);
t1 = 3;
x1_x = 0.5942; 
% syms x1_x a k1 k2 t1 
% eq = x1_x == a - ((a * k1)/((k1*exp(k1*t1))+ (a*k2*(exp(k1*t1)-1))));
% k2_sn = solve(eq, k2);
% disp(k2_sn);


k2_sn = -(k1*exp(k1*t1) - (a*k1)/(a - x1_x))/(a*(exp(k1*t1) - 1))
fprintf('k2_sn: %f\n',k2_sn);



syms x1_x a k1 k2 t1 
eq = x1_x == a - ((a * k1)/((k1*exp(k1*t1))+ (a*k2*(exp(k1*t1)-1))));
a_sn = solve(eq, a);
disp(a_sn);