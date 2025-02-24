syms N(t) q a

ode = diff(N, t) == q - a * N^2;

cond = N(0) == 0;

solution = dsolve(ode, cond);

disp('solution is: ');
disp(solution);