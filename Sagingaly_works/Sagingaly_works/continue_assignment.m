          
t1 = 1;              
t2 = 2;              
N1 = 31.967671;     
N2 = 32.093365;      


fun = @(x) [
    sqrt(x(1)) / sqrt(x(2)) * tanh(sqrt(x(1)) * sqrt(x(2)) * t1) - N1;
    sqrt(x(1)) / sqrt(x(2)) * tanh(sqrt(x(1)) * sqrt(x(2)) * t2) - N2
];


x0 = [n^2, n / (3 + n^2)]; 

options = optimoptions('fsolve', 'Display', 'off');
solution = fsolve(fun, x0, options);


q_adj = solution(1);
a_adj = solution(2);


disp(['Adjusted q: ', num2str(q_adj)]);
disp(['Adjusted a: ', num2str(a_adj)]);


solve_q = @(q, a, t1, N1) sqrt(q) / sqrt(a) * tanh(sqrt(a) * sqrt(q) * t1) - N1;


q_solution = fsolve(@(q) solve_q(q, a_adj, t1, N1), n^2, options);  

q = n^2;
a = n / (3 + n^2);


delta = abs(q_solution - q);

fprintf('q_solution value is %f\n',q_solution);
fprintf('delta value is %f\n',delta);

Nt1 = (sqrt(q) * tanh(sqrt(a) * sqrt(q) * t1)) / sqrt(a);
Nt2 = (sqrt(q) * tanh(sqrt(a) * sqrt(q) * t2)) / sqrt(a);

% Display results for Part (c)
disp(['Calculated N(t1): ', num2str(Nt1)]);
disp(['Calculated N(t2): ', num2str(Nt2)]);
