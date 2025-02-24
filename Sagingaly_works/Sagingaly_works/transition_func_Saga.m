num = [7e-5 7e-10 0.11 0.9];
denom = [7.2e-5, 1.44e-4, 0.12, 8.2, 8.08];


G = tf(num, denom);

info_analyze = stepinfo(G);


disp('Maximum overshoot is : ');
disp(info_analyze.Overshoot);
disp('System rise time:');
disp(info_analyze.RiseTime);
disp('System peak time:');
disp(info_analyze.PeakTime);
disp('System settling time:');
disp(info_analyze.SettlingTime)