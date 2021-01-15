function [out]=plant(in)

t = in;
T = 1;
alpha = 0.9;
output = alpha*(1-exp(-t/T));

out = output;
