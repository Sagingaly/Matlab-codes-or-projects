K = 1; 

num = [7e-10 7e-10 0.11 0.9]; 
denom = [7.2e-10 1.44e-10 0.12 8.2 8.08]; 

sys = tf(num, denom * K);


figure;
[y, t] = step(sys); 
plot(t, y, 'LineWidth', 2);
grid on;
xlabel('Время (с)');
ylabel('Выход y(t)');
title('Переходная характеристика');


overshoot = (max(y) - 1) * 100; 
settlingTimeIdx = find(abs(y - 1) < 0.02, 1, 'last');
if ~isempty(settlingTimeIdx)
    settlingTime = t(settlingTimeIdx); 
    settlingTime = NaN; % 
end


fprintf('Перерегулирование: %.2f%%\n', overshoot);
if isnan(settlingTime)
    fprintf('Время регулирования: не определено (система не успокаивается)\n');
else
    fprintf('Время регулирования: %.2f с\n', settlingTime);
end
