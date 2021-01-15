clear all;
clc;

A = [1, -1.6, 0.64];
B = [0, 0.04, 0];
C = [1, 0.1, 0];
D = [1, 0, 0];
F = [1, 0, 0];
ts = 1;
GMean = 0;
Gsigma = 0.001;

% 1.1 Simulation of system - 2 idpoly construction
modexact = idpoly(A,B,C,D,F,Gsigma,ts)

% 1.1 Simulation of system - 3 input signal generation
u = idinput(1024,'PRBS',[0,1],[-5, 5]);

% 1.1 Simulation of system - 4 Simulate output signal
options = simOptions('AddNoise', false);
ywithoutnoise = sim(modexact,u,options);

% 1.1 Simulation of system - 5 Calculate signal to noise ratio
options1 = simOptions('AddNoise', true);
ywithnoise = sim(modexact,u,options1);
snr = 20*log10(std(ywithoutnoise)/std(ywithnoise - ywithoutnoise));
disp = (['SNR(dB) =' num2str(snr)])


% 1.1 Simulation of system - 6 Identification data
dat = iddata(ywithnoise, u, ts)
figure(1), plot(dat)
figure(2), plot(fft(dat))

dat1 = iddata(ywithoutnoise, u, ts);
figure(3), plot(dat1)
figure(4), plot(fft(dat1))

% 1.2 Identification of the system from the simulated data

nb = 100;
figure(5)
modimp = cra(dat, nb)
figure(5), plot(modimp)
nk = delayest(dat)

% 1.2 Identification of an ARX model

na = 2;
nb = 1;
figure(6)
modarx = arx(dat, [na,nb,nk]);
present(modarx);
resid(dat,modarx);
[y,RT2] = compare(modarx, dat);
FPE = fpe(modarx);
disp(['RT2:' num2str(RT2) '|AIC:' num2str(AIC) '|FPE:' num2str(RT2)]);

% 1.2 Identification of an ARMAX model

na = 2;
nb = 1;
nc = 1;
figure(7)
modarmax = armax(dat, [na,nb,nc,nk]);
present(modarmax);
resid(dat,modarmax);
[y,RT2] = compare(modarmax, dat);
FPE = fpe(modarmax);
disp(['RT2:' num2str(RT2) '|FPE:' num2str(RT2)]);

% 1.2 Identification of an OE model

nf = 2;
nb = 1;
nc = 1;
figure(8)
modOE = oe(dat, [nf,nb,nc,nk]);
present(modOE);
resid(dat,modOE);
[y,RT2] = compare(modOE, dat);
FPE = fpe(modOE);
disp(['RT2:' num2str(RT2) '|FPE:' num2str(RT2)]);

% 1.2 Identification of an OE model

nf = 2;
nb = 1;
nc = 1;
figure(8)
modOE = oe(dat,[nf,nb,nk]);
present(modOE);
resid(dat,modOE);
[y,RT2] = compare(modOE, dat);
FPE = fpe(modOE);
disp(['RT2:' num2str(RT2) '|FPE:' num2str(RT2)]);