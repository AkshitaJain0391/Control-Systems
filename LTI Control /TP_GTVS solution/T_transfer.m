function [out]=T_transfer(in)

%f en bo

%out=s1

t = in;
T = 1;
alpha = 0.9;

r0 = 1/(1-(alpha*(1-exp(-t/T)))^2)- ((2*alpha/T)*(1-exp(-t/T))*exp(-t/T))/((1-(alpha*(1-exp(-t/T)))^2)^2);

out= r0;
