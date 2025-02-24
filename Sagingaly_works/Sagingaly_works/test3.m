% Define constants
n = 10;
k1 = 0.8 + 3 / (n^2 + 1);
a_actual = 0.6 + 5 / (n^2 + 7); % Actual a to check the error
k2 = 0.01 * (5 + 3 / (n + 1));
t1 = 5;
x1_adj = 0.61;


fprintf('a_actual is %f\n',a_actual)
% Calculate quadratic coefficients
A = k2 * (exp(k1 * t1) - 1);
B = -k1 + k1 * exp(k1 * t1) - x1_adj * k2 * (exp(k1 * t1) - 1);
C = -x1_adj * k1 * exp(k1 * t1);

% Display coefficients
fprintf('A = %f\n', A);
fprintf('B = %f\n', B);
fprintf('C = %f\n', C);

% Calculate discriminant
D = B^2 - 4 * A * C;

fprintf('Discriminant D = %f\n', D);

% Check discriminant
if D < 0
    fprintf('No real solutions since D is negative.\n');
else
    % Solve quadratic equation
    a_sn1 = (-B + sqrt(D)) / (2 * A);
    a_sn2 = (-B - sqrt(D)) / (2 * A);

    fprintf('Solution 1 (a_sn1) = %f\n', a_sn1);
    fprintf('Solution 2 (a_sn2) = %f\n', a_sn2);

    % Compare to actual a
    delta1 = abs(a_actual - a_sn1);
    delta2 = abs(a_actual - a_sn2);

    fprintf('Error with a_sn1 (delta1) = %f\n', delta1);
    fprintf('Error with a_sn2 (delta2) = %f\n', delta2);
end

% syms x1_adj a k1 t1 k2 
% eqn = (1/a-x1_adj) - exp(k1*t1)/a - k2/k1 * (exp(k1*t1)-1);
% k1_deriv  = solve(eqn, a);
% disp(k1_deriv);

% syms x1_adj a k1 k2 t1
% eq = x1_adj == a - ((a * k1)/((k1*exp(k1*t1))+ (a*k2*(exp(k1*t1)-1))));
% a_sn = solve(eq,a);
% disp(a_sn);




