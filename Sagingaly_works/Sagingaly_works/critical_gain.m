Krc = 1; 


s = tf('s');
num = 7e-10 * s^4 + 7e-10 * s^3 + 0.11 * s^2 + 0.9 * s;
denom = 7.2e-10 * s^4 + 1.44e-10 * s^3 + 0.12 * s^2 + 8.2 * s + 8.08;


K_values = linspace(0, Krc * 1.5, 100);


stability = arrayfun(@(K) all(real(pole(K * num / denom)) < 0), K_values);

figure;
plot(K_values, stability, 'LineWidth', 2);
xlabel('Коэффициент усиления K');
ylabel('Устойчивость (1 - устойчива, 0 - неустойчива)');
grid on;
title('Область устойчивости в плоскости K');
