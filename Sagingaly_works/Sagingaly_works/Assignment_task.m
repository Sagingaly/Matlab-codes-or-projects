num = [1];
denom = [1 0.4 4];

G = tf(num, denom);

% nyquist(G);
bode(G);