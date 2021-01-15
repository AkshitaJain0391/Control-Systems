%% Loop, robustness and uncertainties
clear all
close all
clc

%% Exercise 2

Kp = 0.5;
% controller
Hr = Kp; 
% Plant
Hp = tf(1, [1 1 0]); 
Hm = tf(1, [3 1]);

G = Hp*Hm;
%% Loop transfer function L

L = Hr*G;
% Sensitive function
S = (1+G*Hr)^-1;
T = 1 - S;

figure(1)
bode(L);
figure(2)
margin(L);

[Gm,Pm,Wcg,Wcp] = margin(L);
Wo = Wcg;
W180 = Wcp;

% The results indicate that a gain variation of over Wcg dB 
dK = Gm;

figure(3)
ax1 = subplot(3,1,1);
asym_stable_closed_loop = feedback(Hr*G, 1, -1);
step(asym_stable_closed_loop);
title(ax1,'Asymptomatic stable system');

ax2 = subplot(3,1,2);
Hr = Kp+ dK;
mar_stable_closed_loop = feedback(Hr*G, 1, -1);
step(mar_stable_closed_loop);
title(ax2,'Marginally stable system');

ax3 = subplot(3,1,3);
Hr = Kp + dK + 0.1;
unstable_closed_loop = feedback(Hr*G, 1, -1);
step(unstable_closed_loop);
title(ax3,'unstable system');

