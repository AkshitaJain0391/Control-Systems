% Filtering of an audio signal

clear all;
clc;

% Signal generation and analysis
duree = 1;
fs = 8192;
fmin = 250;
fmax = 550;
[y,t] = gamme(duree,fs);
soundsc(y,fs)

subplot(2,2,1)
figure(1);
plot(y)

subplot(2,2,2)
fsig = [0:length(y)-1]*(fs/length(y));
s = fft(y)/fs;
plot(fsig, abs(s)); axis([fmin fmax 0 1.1*max(abs(s))])

%% 1.1 Analog Low pass filtering

Rp = 3;
Rs = 40;
fc = 420;
delf = 100; % Delta frequency 
Fp = 370;
Fs = 470;
dels = 10^(-Rs/20)
delp = 10^(-Rp/20)
Vs = Fs/Fp
fmin = 250;
fmax = 550;

%Filters
[nc, wnc] = buttord(2*pi*Fp,2*pi*Fs,Rp,Rs,'s'); %Butterworth filter
[nca, wnca] = cheb1ord(2*pi*Fp,2*pi*Fs,Rp,Rs,'s'); %Chebychev filter_1
[ncb, wncb] = cheb1ord(2*pi*Fp,2*pi*Fs,Rp,Rs,'s'); %Chebychev filter_2
[ncc, wncc] = ellipord(2*pi*Fp,2*pi*Fs,Rp,Rs,'s'); %Cueur filter

%Transfer functions
[num, dend] = butter(nc,wnc,'low','s');
[numa, denda] = cheby1(nca,Rp,wnca,'low','s');
[numb, dendb] = cheby2(ncb,Rs,wncb,'low','s');
[numc, dendc] = ellip(ncc,Rp,Rs,wncc,'low','s');

subplot(2,2,1)
figure(2);

f = linespace(fmin,fmax,1000);
Hb = freqs(num,dend,2*pi*f);
plot(f,20*log10(abs(Hb)))
hold;

subplot(2,2,2)
f = linespace(fmin,fmax,1000);
Hc = freqs(numa,denda,2*pi*f);
plot(f,20*log10(abs(Hc)))
hold;

subplot(2,2,3)
f = linespace(fmin,fmax,1000);
Hd = freqs(numb,dendb,2*pi*f);
plot(f,20*log10(abs(Hd)))
hold;

subplot(2,2,4)
f = linespace(fmin,fmax,1000);
He = freqs(numc,dendc,2*pi*f);
plot(f,20*log10(abs(He)))
hold;















