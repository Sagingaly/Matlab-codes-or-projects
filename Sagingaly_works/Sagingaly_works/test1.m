% Define symbolic variables
syms k1_init t1 k2_init x1_adj a t2 x2_adj

% Define functions F and G
F = (1 / a - x1_adj) - exp(k1_init * t1) / a - (k2_init / k1_init) * (exp(k1_init * t1) - 1);
% G = (1 / a - x2_adj) - exp(k1_init * t2) / a - (k2_init / k1_init) * (exp(k1_init * t2) - 1);


fprintf('F expression: %s\n', char(F));
fprintf('G expression: %s\n', char(G));


deriv_F = diff(F, k1_init);

disp('Derivative of F with respect to k1_init:');
disp(deriv_F);
