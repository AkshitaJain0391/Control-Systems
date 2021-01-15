%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Loop Shaping%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc

G=tf(1,[1 2*0.3/sqrt(5) 5]);

Ng=cell2mat(G.num);
Dg=cell2mat(G.den);
% A = 0.1; % test 1
 A = 0.001;% 0.01 test 2 %W2
% A = 1;% test 3
Wu = tf(A); %W2
Wt = tf(0); %W3
M = 2;wb = 1.5;ep = 0.0001;
Wp=tf([1/M wb],[1 wb*ep]); %W1
  
P=augw(G,Wp,Wu,Wt);

%[K,CL,GAM,INFO] = mixsyn(G,Wp,[],[]);

[K1,CL1,GAM1,INFO1] = hinfsyn(P);
[K2,CL2,GAM2] = h2syn(P);

L=tf(K1)*1*G;
Hbf=L/(1+L);
figure(1)
step(Hbf)
Nk=cell2mat(tf(K1).num);
Dk=cell2mat(tf(K1).den);
%%%%%%%%%%%%%%%%%%%%%%%%%%%

L2=tf(K2)*1*G;
Hbf2=L2/(1+L2);
figure(2)
step(Hbf2)

Nk2=cell2mat(tf(K2).num);
Dk2=cell2mat(tf(K2).den);
% fonctions de sensibilité

S2=1/(1+L2);
T2=L2/(1+L2);
figure(3)
bode(Wp)

% 