% Autocatalytic reaction, Inverse problem
% x_adj = (k1 + k2(a-x))(a-x);
% x(0) = 0;

% Variables
n = 10;

% Given parameters
k1 = 0.8 + 3 / (n^2 + 1);
a = 0.6 + 5 / (n^2 + 7);
k2 = 0.01 * (5 + 3 / (n + 1));
epsilon_1 = 0.01 + 3 / (n^2 + 4);
t1 = 3;
t2 = 5;  % New time for the second task

fprintf('k1 value is: %f\n', k1);
fprintf('a value is: %f\n', a);
fprintf('k2 value is: %f\n', k2);
fprintf('epsilon_1 value is: %f\n', epsilon_1);

% Calculation of x1 at time t1
x1 = a - (a * k1 / (k1 * exp(k1 * t1) + a * k2 * (exp(k1 * t1) - 1)));

fprintf('x1 value is: %f\n', x1);

% Calculating x1_adj using epsilon_1
x1_adj = x1 * (1 + epsilon_1);

fprintf('x1_adj value is: %f\n', x1_adj);

% Calculation of k2_adj
k2_adj = (a * k1 - k1 * exp(k1 * t1) * (a - x1)) / ((a - x1) * a * (exp(k1 * t1) - 1));

fprintf('k2_adj value is: %f\n', k2_adj);

% Calculating k2_adj_adj using epsilon_1
k2_adj_adj = k2_adj * (1 + epsilon_1);

fprintf('k2_adj_adj value is: %f\n', k2_adj_adj);

% Calculate delta
delta = abs(k2 - k2_adj_adj);

fprintf('delta value is: %f\n', delta);

% Task 2: Finding a_adj based on x1_adj at time t2
x1_adj = a - (a * k1 / (k1 * exp(k1 * t2) + a * k2 * (exp(k1 * t2) - 1)));

epsilon_1 = 0.01 + 3 / (n^2 + 4);

% Adjust x1 to x1_adj using epsilon_1
x1_adj = x1 * (1 + epsilon_1);

fprintf('x1_adj value at t2=%f: %f\n', t2, x1_adj);

% Solving for a_adj based on x1_adj
% syms a k1 t2 k2 x1_adj

% equation = x1_adj == a - (a * k1 / (k1 * exp(k1 * t2) + a * k2 * (exp(k1 * t2) - 1)));

% a_adl_solution=solve(equation,a);

% disp(a_adl_solution)


a_adj = x1 + (x1 * k1 / (k1 * exp(k1 * t2) + x1 * k2 * (exp(k1 * t2) - 1)));

fprintf('a_adj value is: %f\n', a_adj);

a_adj_adj = a_adj * (1+epsilon_1);

% Calculate delta_2
delta_2 = abs(a - a_adj_adj);

fprintf('delta_2 value is: %f\n', delta_2);





