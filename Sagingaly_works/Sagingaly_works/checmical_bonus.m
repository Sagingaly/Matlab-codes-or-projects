%% 
syms k1 x x0 y0 k2 v0 u0
x_prime = -k1*x *(x - x0 +y0) + k2*(x0 -x + u0)*(x0 - x +v0);  
eqn = x_prime == -k1*x *(x - x0 +y0) + k2*(x0 -x + y0)*(x0 - x +v0);
% solution = expand(eqn);
% disp(solution);
expanded_eqn = expand(eqn);
collected_eqn = collect(expanded_eqn, x);
disp(collected_eqn);

