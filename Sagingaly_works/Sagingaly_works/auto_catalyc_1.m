function F = system_equations(k)
    % Extract k1 and k2 from the input vector k
    k1 = k(1);
    k2 = k(2);
    
    % Given parameters
    n = 10;
    t1 = 3;
    t2 = 5;
    a = 0.6 + 5 / (n^2 + 7);
    
    % F1 and F2 as functions of k1 and k2
    F(1, 1) = a - (a * k1 / (k1 * exp(k1 * t1) + a * k2 * (exp(k1 * t1) - 1)));  % Equation 1
    F(2, 1) = a - (a * k1 / (k1 * exp(k1 * t2) + a * k2 * (exp(k1 * t2) - 1)));  % Equation 2
end

function k = newton_method(system_equations, k0, tol)
    max_iter = 200; % Increase max iterations
    epsilon = 1e-6; % Perturbation for finite difference
    n = length(k0); % Number of variables

    lambda = 1e-4; % Increased regularization parameter
    
    for i = 1:max_iter
        % Compute the function values at the current guess
        F = system_equations(k0);
        
        % Initialize Jacobian matrix
        J = zeros(n, n);
        
        % Compute the Jacobian matrix numerically using finite differences
        for j = 1:n
            k_perturb = k0;
            k_perturb(j) = k0(j) + epsilon; % Perturb the j-th variable
            F_perturb = system_equations(k_perturb); % Function value with perturbation
            
            % Approximate the partial derivative
            J(:, j) = (F_perturb - F) / epsilon; % Finite difference approximation
        end
        
        % Check the condition number of the Jacobian
        cond_J = cond(J);
        fprintf('Iteration %d: Condition number of Jacobian: %e\n', i, cond_J);

        % Apply regularization if the Jacobian is ill-conditioned
        if cond_J > 1e10
            J = J + lambda * eye(n); % Add a small identity matrix to the Jacobian
            warning('Regularization applied to the Jacobian at iteration %d', i);
        end

        % Solve for the correction delta_k
        delta_k = -J \ F;

        % Update the solution estimate
        k = k0 + delta_k;

        % Evaluate the convergence criterion
        error = norm(delta_k);
        fprintf('Iteration %d: Error = %e\n', i, error);

        % Check for convergence
        if error < tol
            fprintf('Converged at iteration %d\n', i);
            return;
        end

        % Update the guess for the next iteration
        k0 = k;
    end

    % If the method didn't converge, print a warning
    warning('Newton method did not converge within the maximum number of iterations');
end

% Example usage
% Initial guess for k1 and k2
k0 = [0.8; 0.01];

% Desired tolerance for convergence
tol = 1e-4; % Increased tolerance to allow for larger errors

% Call the Newton method with the function handle
k = newton_method(@system_equations, k0, tol);

% Display the result
fprintf('Final solution: k1 = %f, k2 = %f\n', k(1), k(2));

% Display the number in scientific notation
formatted_result = sprintf('%.7e', 3.133246e-05);
disp(formatted_result);
