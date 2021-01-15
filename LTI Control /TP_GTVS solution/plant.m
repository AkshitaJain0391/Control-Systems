function [out]=plant(in)

ex=exp(in);

out=(ex-ex^(-1))/(ex+ex^(-1));
