G = tf([1], [1 0.2683 5]);
W1 = tf([1,1.5], [1,0.00015]);
%W1 = tf([1,5], [1,0.0005]);
W2 = 0.1;
W3 = 0;
P = augw(G,W1,W2,W3);
K1 = hinfsyn(P)
K2 = h2syn(P)
bode(W1)