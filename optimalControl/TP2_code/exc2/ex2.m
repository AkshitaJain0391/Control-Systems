clear, clc, clf
% Define Transfer functions
% The Process Transfer function Hp(s)
num_p=[1];
den1=[1, 0];
den2=[1, 1];
den_p = conv(den1,den2);
Hp = tf(num_p, den_p)
% The Measurement Transfer function Hm(s)
num_m=[1];
den_m=[3, 1];
Hm = tf(num_m, den_m)
% The Controller Transfer function Hr(s)
Kp = 0.5;
Hr = tf(Kp)
% The Loop Transfer function
L = series(series(Hr, Hp), Hm)
% Bode Diagram
figure(1)
bode(L)
subplot(2,1,1)
grid on
subplot(2,1,2)
grid on
figure(2)
margin(L)
[gm, pm, w180, wc] = margin(L);
wc
w180
gmdB = 20*log10(gm)
pm