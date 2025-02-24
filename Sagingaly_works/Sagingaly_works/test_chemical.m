% Given parameters
n = 10;
a = 3 + 1/(n^2 + 1);
b = 4 + 2/(n^2 + 1);
k = 0.01 + 2/(100 * (n^2 + 1));
epsilon1 = 0.01 + 3 / (n^2 + 4);
t1 = 1;

% Task 1: Find x1 at time t1
x1 = a - (a / (k * t1 * a + 1));
fprintf('x1 value is: %f\n', x1);

% Task 2: Calculate x1_adj = x1 * (1 + epsilon1)
x1_adj = x1 * (1 + epsilon1);
fprintf('x1_adj value is: %f\n', x1_adj);


% Task 3
syms k_v

equation = x1_adj == a - (a / (k_v * t1 * a + 1));

k_solution = double(solve(equation, k_v));

k_adj = k_solution(k_solution > 0);

if ~isempty(k_adj)
    k_adj = k_adj(1);
else
    error('Not found')
end

delta = abs(k - k_adj);

fprintf('The value of delta is: %f\n', delta);

