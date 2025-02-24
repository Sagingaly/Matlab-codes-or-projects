% Параметры
k = 1;      % Коэффициент
a = 5;      % Параметр a
b = 4;      % Параметр b
c = 3;      % Параметр c

% Начальное условие и интервал времени
x0 = 0;          % Начальное значение x(0)
tspan = [0 10];  % Интервал времени [t0, tf]

% Уравнение в виде функции
dxdt = @(t, x) k * (a - x) * (b - x) * (c - x);

% Решение с использованием ode45
[t, x] = ode45(dxdt, tspan, x0);

% Построение графика
figure;
plot(t, x, 'LineWidth', 2);
grid on;
xlabel('Time, t');
ylabel('Solution, x(t)');
title('Численное решение dx/dt = k(a-x)(b-x)(c-x)');
