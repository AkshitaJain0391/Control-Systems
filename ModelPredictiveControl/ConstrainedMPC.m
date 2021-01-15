%% Constrained MPC - Receding Horizon Control
%% Umin <= U <= Umax 

%% System Definition : 
%% x_1 = position, x_2 = velocity, u = acceleration

A = [1 1; 0 1];
B = [0; 1];
C = [1 0; 0 1]
D = [0];
xp = [10; 0];
Ts = 1;
t_sim = 1:Ts:29;
T_sim = size(t_sim,2);  %: get the array size  %100 or 1000

umax = 1;
umin = -1;

Umax = [umax; umax]; % (row of U matrix * 1
Umin = [umin; umin];


%% Given parameters : 
N = 2;
R = 1/10; % Try for R = 6 and compare with the results
Q = [1 0; 0 0];
P = [1 0; 0 1];

%% Cost Function :
%% min J(U) = x0^T*Q*x0 + (Sx*x0 + Su*U)^T*Q_bar*(Sx*x0 + Su*U) + U^T*R_bar * U
%% Grad(J(U)) = 0 implies U_ = -inv(G)*F*x0

Sx = [A; A^2];
Su = [B [0;0]; A*B B];

%Q_bar = [Q 0 0 ...0; 0 Q 0..0; 0 0 Q 0..0;.....;0 0 0 ....P]
Q_bar = [Q zeros(2,2); zeros(2,2) P];

R_bar = [R 0; 0 R] %Block diagonal of R

F = Su'*Q_bar*Sx; 

G = R_bar + Su'* Q_bar * Su;

H = 2*G;  % for Quadprog solver

K0 = -[1 0]*inv(G)*F;   %% extract first element of optimal control vector

%% Constrained parameter

E = [eye(2,2); -eye(2,2)]
b = [Umax; -Umin]
%% RHC - Loop for repeatedly solving the constrained optimisation problem

for i = 1:Tsim-1
    
    x0 = xp;
    y = C*xp;
    f = 2*(F*xp);
    [U_opt, t] = quadprog(H, f, E, b)
    Up = U_opt(1)
    u(:,i) = Up;
    xp = A*xp + B*Up; 
    x(:,i) = xp
   
end

%figure(1); plot(x(1,:)); xlabel('time'); ylabel('Position');
%figure(2); plot(x(2,:)); xlabel('time'); ylabel('Velocity');
figure(2); plot(t_sim, x); xlabel('time'); ylabel('Position and Velocity');
figure(3); plot(u); xlabel('time'); ylabel('Constrained Control Output');



    
    
    