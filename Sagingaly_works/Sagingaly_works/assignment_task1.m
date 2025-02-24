num = [1];
denom = [1 0.4 4];

G = tf(num, denom);


info_analyze = stepinfo(G);



disp('System overshoot:');
disp(info_analyze.Overshoot);
disp('System rise time:');
disp(info_analyze.RiseTime);
disp('System peak time:');
disp(info_analyze.PeakTime);
disp('System settling time:');
disp(info_analyze.SettlingTime);