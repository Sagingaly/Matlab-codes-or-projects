num = [200 100] ;
denom = [1 60 50];

G = tf(num, denom);


bodeplot(G);