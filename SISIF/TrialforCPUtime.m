% Discrete System
tic;
initime = cputime;
sys = tf([0,0,4] ,[1, 0 ,4]);
sysd = c2d(sys, 0.1);
% sysd = ss([0 1;-4 0], [0; 4] ,[1 0], 0);
% [numd,dend] = tfdata(sysd) ;
[At,Bt,Ct] = ssdata(sysd);
[N,Xe] = ore(@navettediscrete,[0 8/ts],[0;0],At,Bt,ts);
alpha2 = Ct*Xe'+0.3;
N=N*ts;

%Computation time for discrete system

%time1   = clock;
%pause(1.0);  % Wait for a second;
fintime = cputime;
elapsed = toc;
%time2   = clock;
fprintf('TIC TOC1: %g\n', elapsed);
fprintf('CPUTIME1: %g\n', fintime - initime);

%%
function [N, Xe] = ore(equarec, N, x0, varargin)
x0 = x0(:); % assurer un vecteur colonne / ensures a column vector
dim = length(x0); % dimension du vecteur d’etat / state vector dimension
Duree = N(2) - N(1) + 1; % duree de la resolution / time length
N = N(1):N(2);
Xe = zeros(Duree, dim);
xe = x0;
indmatlab = 1;
for n = N
    Xe(indmatlab,:) = xe';
    xe = equarec(n, xe, varargin{:});
    indmatlab = indmatlab + 1;
end
end

function xpoint = navettecontinue(t,x,A,B)
if (t<1)
    xpoint = A*x;
else
    xpoint = A*x+B*0.05;
end
end

function xeplus = navettediscrete(n,xe,Atilde,Btilde,ts)
if (n*ts<1)
    xeplus = Atilde*xe;
else
    xeplus = Atilde*xe+Btilde*0.05;
    
end
end

