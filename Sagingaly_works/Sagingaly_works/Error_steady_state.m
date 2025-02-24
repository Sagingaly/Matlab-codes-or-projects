num = [7e-10 7e-10 0.11 0.9];
denom = [7.2e-10 1.44e-10 0.12 8.2 8.08];

system = tf(num, denom);

stady_state_error = dcgain(feedback(system,1));

fprintf('steady state error is %.6f\n', steady_state_error);

fprintf('The overall error of the system  %.4f\n', 1- steady_state_error);
