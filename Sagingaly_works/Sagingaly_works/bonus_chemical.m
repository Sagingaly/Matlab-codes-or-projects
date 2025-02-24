N = 31.967;  
a = 10/3 + 100;  
t1 = 1;  


fun = @(q) (sqrt(q)*tanh(sqrt(a)*sqrt(q)*t1))/sqrt(a) - N;


q0 = 100;


q_solution = fsolve(fun, q0);

disp('Решение для q:');
disp(q_solution);
