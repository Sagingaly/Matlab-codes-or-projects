syms x(t) a k
ode = diff(x, t) == k*(a-x)^2;
init_cond = x(0)== 0;
solution = dsolve(ode, init_cond);
disp('solution is:');
disp(solution);


n = 10;
a = 3 + (1/n^2+1);
b = 4 + (2/n^2+1);
k = 0.01 + (2/100*(n^2+1)); 
eps = 10e-3;
t1 = 3;


fprintf('The value of a is: %.4f\n', a);
fprintf('The value of b is: %.4f\n', b);
fprintf('The value of k is: %.6f\n', k);

x1 = a^2*k*t1/(a*k*t1+1);
fprintf('The value of x1 is: %.4f\n', x1);

x_adj = x1*(1+eps);
fprintf('The value of x_adj is: %.4f\n', x_adj);

% syms a k t x_solution 
% equation = x_solution == (a^2*k*t)/(a*k*t + 1);
% k_sn = solve(equation, k);
% disp(k_sn);


x_solution = x1;
k_adj1 = x1/(t1*a^2 - t1*x1*a);
fprintf('k_adj1 is: %f\n', k_adj1);


k_adj_adj = k_adj1*(1+eps);

delta = abs(k- k_adj_adj);
fprintf('delta value is: %f\n', delta);

