syms N(t) q a

ode = diff(N, t) == q - a * N^2;

cond = N(0) == 0;

solution = dsolve(ode, cond);

disp('solution is: ');
disp(solution);


% Task 2
t1 = 1;
n = 10;
q = n^2;
a = n/(3+n^2);
t2 = 2;
Nt1 = @(t1, a, q) (sqrt(q)*tanh(sqrt(a)*sqrt(q)*t1))/sqrt(a);
Nt2 = @(t2, a, q) (sqrt(q)*tanh(sqrt(a)*sqrt(q)*t2))/sqrt(a);

fprintf('Nt1 value is: %f\n', Nt1(t1, a , q));
fprintf('Nt2 value is: %f\n', Nt2(t2, a , q));
fprintf('a value is %f\n',a)
fprintf('q value is %f\n',q)
 
% Task 3, finding q 
% syms N a q t1
% eqn = N == (sqrt(q)*tanh(sqrt(a)*sqrt(q)*t1))/sqrt(a);
% solution = solve(eqn, q);


% disp('solution is:');
% disp(solution);
t1 = 1;
n = 10;
a = n/(3+n^2);
Nt1 = 31.967671;

fun = @(q) (sqrt(q)*tanh(sqrt(a)*sqrt(q)*t1))/sqrt(a) - Nt1;


q0 = 1;

q_solution = fsolve(fun, q0);

disp('Решение для q:');
disp(q_solution);

