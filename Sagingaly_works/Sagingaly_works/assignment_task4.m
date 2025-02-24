num = input('Enter num coeffs: ');
denom = input('Enter denom coeffs: ');

G = tf(num, denom);

omega = logspace(-2, 2, 1000);
[mag, phase] = bode(G, omega);  
mag = squeeze(mag);
phase = squeeze(phase);

real_G = mag .* cosd(phase);
imag_G = mag .* sind(phase);

figure;
plot(real_G, imag_G, 'b', 'LineWidth', 2);
hold on;
plot(real_G, -imag_G, 'b', 'LineWidth', 2);
plot(-1, 0, 'ro');
xlabel('Real');
ylabel('Imaginary');
title('Nyquist Plot');
grid on;

if any(real_G < -1 & imag_G == 0)
    disp('System is unstable.');
else
    disp('System is stable.');
end

