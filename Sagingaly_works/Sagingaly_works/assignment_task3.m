num = input('Enter num coeffs: ');
denom = input('Enter denom coeffs: ');

G = tf(num, denom); 

% disp('Transfer function G is:');
% disp(G);

nyquist(G);
