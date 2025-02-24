t1 = 393;
t2 = 1010;
t3 = 1265;
a =  0.5638;
b = 0.3114;
c = 0.4899;
d = 0.2342;

% k = (1/t1*(0.5638-0.3114))* (log(0.4899)-log(0.2342)-log(0.5638/0.3114));
k1 = (1/t1*(a-b))* (log(c)-log(d)-log(a/b));
k2 = (1/t2*(a-b))* (log(c)-log(d)-log(a/b));
k3 = (1/t3*(a-b))* (log(c)-log(d)-log(a/b));


fprintf('K valuse is: %f\n', k1);
fprintf('K valuse is: %f\n', k2);
fprintf('K valuse is: %f\n', k3);



% Given parameters
n = 10;
a = 3 + 1/(n^2+1);
b = 4 + 2/(n^2+1);
k = 0.01 + 2/(100*(n^2+1));
epsilon1 = 0.01 + 3 / (n^2 + 4);
t1 = 1;




% Equations 
% Task 1, find x1 at time moment t1 
x1 = a - (a/(k*t1*a+1)); 
x2 = b - (b/(k*t1*b+1));


fprintf('x1 value is: %f\n', x1);
fprintf('x1 value is: %f\n', x2);


% Task 2, calculate x1_adj = x1*(1+epsilon_1);
x1_adj = x1 *(1+epsilon1); 
x2_adj = x2 *(1+epsilon1);

fprintf('x1_adj value is: %f\n', x1_adj);
fprintf('x2_adj value is: %f\n', x2_adj);


% Task 3, find the value k_adj
syms k a t1 x1_adj 
eqn = x1_adj == a - (a/(k*t1*a+1)); 
k_solution = solve(eqn, k);
disp(k_solution);



% Formula x1_adj/(t1*a^2 - t1*x1_adj*a) 

k_adj = x1_adj/(t1*a^2 - t1*x1_adj*a); 
k_adj2 = x2_adj/(t1*b^2 - t1*x2_adj*b);  

fprintf('k_adj value is: %f\n',k_adj);
fprintf('k_adj2 value is: %f\n',k_adj2);

delta = abs(k - k_adj);
delta2 = abs(k-k_adj2);

fprintf('delta value is: %f\n',delta);
fprintf('delta value is: %f\n',delta2);




% Chapter 2
a = 3 + 1/n^2+1;
x1 = a - (a/(k*t1*a+1)); 
x2 = b - (b/(k*t1*b+1));


fprintf('x1 value is: %f\n', x1);
fprintf('x1 value is: %f\n', x2);


% Task 2, calculate x1_adj = x1*(1+epsilon_1);
x1_adj = x1 *(1+epsilon1); 
x2_adj = x2 *(1+epsilon1);

fprintf('x1_adj value is: %f\n', x1_adj);
fprintf('x2_adj value is: %f\n', x2_adj);


% Task 3, find the value k_adj
% syms k a t1 x1_adj 
% eqn = x1_adj == a - (a/(k*t1*a+1)); 
% k_solution = solve(eqn, k);

% Formula x1_adj/(t1*a^2 - t1*x1_adj*a) 

k_adj = x1_adj/(t1*a^2 - t1*x1_adj*a); 
k_adj2 = x2_adj/(t1*b^2 - t1*x2_adj*b);  

fprintf('k_adj value is: %f\n',k_adj);
fprintf('k_adj2 value is: %f\n',k_adj2);

delta = abs(k - k_adj);
delta2 = abs(k-k_adj2);

fprintf('delta value is: %f\n',delta);
fprintf('delta value is: %f\n',delta2);
