clc;
clear;

K_values = 1:0.05:4;
a_values = 0.4:0.05:4;

G = tf(1.2, conv([0.3, 1], conv([1, 1], [1.2, 1])));

overshoot_min = 2;
overshoot_max = 10;
settling_time_max = 2;

optimal_K = NaN;
optimal_a = NaN;
first_response = [];

for K = flip(K_values)
    for a = flip(a_values)
        PID = K * tf([1, 2*a, a^2], [1, 0]);
        T = feedback(PID * G, 1);
        info = stepinfo(T);
        overshoot = info.Overshoot;
        settling_time = info.SettlingTime;
        if overshoot >= overshoot_min && overshoot <= overshoot_max && settling_time <= settling_time_max
            optimal_K = K;
            optimal_a = a;
            first_response = T;
            break;
        end
    end
    if ~isnan(optimal_K)
        break;
    end
end

if isnan(optimal_K)
    disp('No suitable K and a found.');
else
    fprintf('Optimal parameters: K = %.2f, a = %.2f\n', optimal_K, optimal_a);
    step(first_response);
    title('Step Response');
    grid on;
end
