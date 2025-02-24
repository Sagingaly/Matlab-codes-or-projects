% Task 3
% Параметры задачи
n = 10;
k1 = 0.8 + 3 / (n^2 + 1);
a = 0.6 + 5 / (n^2 + 7);
k2 = 0.01 * (5 + 3 / (n + 1));
epsilon_1 = 0.01 + 3 / (n^2 + 4);
t1 = 1; % время t1
t2 = 2; % время t2

fprintf('k1 value is: %f\n', k1);
fprintf('a value is: %f\n', a);
fprintf('k2 value is: %f\n', k2);
fprintf('epsilon_1 value is: %f\n', epsilon_1);


% Начальные приближения для метода Ньютона
k1_init = 0.8;
k2_init = 0.01;

x1 = a - (a * k1 / (k1 * exp(k1 * t1) + a * k2 * (exp(k1 * t1) - 1)));
x2 = a - (a * k1 / (k1 * exp(k1 * t2) + a * k2 * (exp(k1 * t2) - 1)));

x1_adj = x1 * (1 + epsilon_1);
x2_adj = x2 * (1 + epsilon_1);


% Параметры для метода Ньютона
tol = 1e-6; % допустимая погрешность
max_iter = 100; % максимальное количество итераций

% Функции F и G
% syms k1 t1 k2 x1_adj a

F =(1/a - x1_adj) - exp(k1_init * t1) / a - (k2_init / k1_init) * (exp(k1_init * t1) - 1);
G =(1/a - x2_adj) - exp(k1_init * t2) / a - (k2_init / k1_init * (exp(k1_init * t2) - 1);


fprintf('F value: %f\n', F);
fprintf('G value: %f\n', G);

% deriv_F = diff(F,k1);
% deriv_G = diff(G,k2);
% deriv_F_k2 = diff(F,k2);
% deriv_G_k1 = diff(G,k1);


% disp(deriv_F);
% disp(deriv_G);
% disp(deriv_F_k2);
% disp(deriv_G_k1);


F_k1 = (k2_init*(exp(k1_init*t1) - 1))/k1_init^2 - (t1*exp(k1_init*t1))/a - (k2_init*t1*exp(k1_init*t1))/k1_init;
G_k2 = -(exp(2*k1_init) - 1)/k1_init;
F_k2 = -(exp(k1*t1) - 1)/k1;
G_k1 = (k2*(exp(2*k1) - 1))/k1^2 - (2*exp(2*k1))/a - (2*k2*exp(2*k1))/k1;

fprintf('F value is: %f\n', F_k1);
fprintf('G value is: %f\n', G_k2);
fprintf('F_k2 value is: %f\n', F_k2);
fprintf('G_k1 value is: %f\n', G_k1);

det_k1_k2 = (F_k1 * G_k2) - (F_k2 * G_k1);
det_k1 = (G_k2 * F) - (F_k2 * G);
det_k2 = (G_k2 * F) - (F_k2 * G);

fprintf('det_k1_k2 valuse: %f\n', det_k1_k2);
fprintf('det_k1 valuse: %f\n', det_k1);
fprintf('det_k2 valuse: %f\n', det_k2);


% Частные производные F и G
% F_k1 = @(k1, k2) (-t1 * exp(k1 * t1) / a) + (k2 * t1 * exp(k1 * t1) - k2 * (exp(k1 * t1) - 1)) / (k1^2);
% F_k2 = @(k1, k2) -(exp(k1 * t1) - 1) / k1;
% G_k1 = @(k1, k2) (-t2 * exp(k1 * t2) / a) + (k2 * t2 * exp(k1 * t2) - k2 * (exp(k1 * t2) - 1)) / (k1^2);
% G_k2 = @(k1, k2) -(exp(k1 * t2) - 1) / k1;


% Итерационный процесс метода Ньютона
for iter = 1:max_iter
    % Вычисление значений функций F и G и их частных производных
    F_val = F(k1, k2);
    G_val = G(k1, k2);
    Fk1 = F_k1(k1, k2);
    Fk2 = F_k2(k1, k2);
    Gk1 = G_k1(k1, k2);
    Gk2 = G_k2(k1, k2);

    % Вычисление детерминантов для метода Ньютона
    delta_k = Fk1 * Gk2 - Fk2 * Gk1;
    delta_k1 = F_val * Gk2 - Fk2 * G_val;
    delta_k2 = Fk1 * G_val - F_val * Gk1;

    % Обновление значений k1 и k2
    k1_new = k1 - delta_k1 / delta_k;
    k2_new = k2 - delta_k2 / delta_k;

    % Вычисление относительных ошибок
    psi1 = abs((k1 - k1_new) / k1);
    psi2 = abs((k2 - k2_new) / k2);

    % Вывод результатов текущей итерации
    fprintf('Итерация %d: k1 = %.6f, k2 = %.6f, psi1 = %.6e, psi2 = %.6e\n', iter, k1_new, k2_new, psi1, psi2);

    % Проверка на сходимость
    if psi1 < tol && psi2 < tol
        fprintf('Сходимость достигнута после %d итераций.\n', iter);
        k1 = k1_new;
        k2 = k2_new;
        break;
    end

    % Обновление значений для следующей итерации
    k1 = k1_new;
    k2 = k2_new;
end

% Проверка, если максимальное количество итераций достигнуто
if iter == max_iter
    fprintf('Максимальное количество итераций достигнуто без сходимости.\n');
end

% Вывод финальных значений
fprintf('Результаты: k1 = %.6f, k2 = %.6f\n', k1, k2);
