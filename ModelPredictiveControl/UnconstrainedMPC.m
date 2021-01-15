%% MPC Implementation 
%% Unconstrained MPC implies No control and state constraints

%% System Definition : 
%% x_1 = position, x_2 = velocity, u = acceleration

A = [1 1; 0 1];
B = [0; 1];
C = [1 0; 0 1]
D = [0];
x0 = [10; 0];
Ts = 1;
Tsim = 10; %100 or 1000

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
K0 = -[1 0]*inv(G)*F;   %% extract first element of optimal control vector

%% Closed loop System

sys_CL = ss((A+B*K0), B, C, [], Ts)
[y,t,x] = initial(sys_CL, x0, Tsim)

%% Plot Results 
plot(t, y, 'LineWidth',2)
xlabel('time')
ylabel('Position and Velocity')



