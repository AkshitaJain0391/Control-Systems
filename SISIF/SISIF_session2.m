%% Laboratory work _Session2

clear all;
clc;

% Modelling of the mechanical process

load('tergane20.mat', 'yc');
load('tergane20.mat', 'z');

P = 2.91;
ts = 0.001;
Kz = 1;
Ky = 1;
T1 = 1;
T2 = 1;

mech_sys = tf([(P*Kz)/(T1*T2), 0], [1, ((T1+T2)/(T1*T2)), 1/(T1*T2), (P*Ky)/(T1*T2)])
mech_dsys = c2d(mech_sys,ts,'tustin')
[num, den, ts] = tfdata(mech_sys)

% Identification of an ARXMAX model
load('tergane20.mat', 'yc');
load('tergane20.mat', 'z');
ts = 0.001;
dat = iddata(z, yc, ts);
nk = delayest(dat)

na = 3;
nb = 3;
nc = 0;
nk = 1;
figure(7)
modarmax = armax(dat, [na,nb,nc,nk]);
present(modarmax);
resid(dat,modarmax);
[y,RT2] = compare(modarmax, dat);
FPE = fpe(modarmax);
disp(['RT2:' num2str(RT2) '|FPE:' num2str(RT2)]);

systf = d2c(modarmax, 'zoh')
[num1,den1,ts1] = tfdata(systf)