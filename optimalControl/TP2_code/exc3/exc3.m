  A=[-1 1;1 -1];
  B=[1;1]

  setlmis([]);
  P=lmivar(1,[2,1]);
  Q=lmivar(1,[2,1]);
  R=lmivar(1,[1,1]);
      
  lmiterm([-1 1 1 P],1,1);                          % LMI #1: P>0

  lmiterm([-2 1 1 Q],1,1);                        % LMI #2: Q>0

  lmiterm([-3 1 1 R],1,1);                        % LMI #3: R>0

  lmiterm([4 1 1 P],A',1,'s');                         % LMI #4: 
  lmiterm([4 1 1 Q],1,1);                    
  lmiterm([4 1 2 P],1,B);                        
  lmiterm([4 2 2 R],-1,1);                        

LMIs=getlmis;
  [TMIN,TFEAS]=feasp(LMIs);
  Q=dec2mat(LMIs,TFEAS,Q);
  P=dec2mat(LMIs,TFEAS,P);
  R=dec2mat(LMIs,TFEAS,R);
  
  K1=inv(R)*B'*P;   %computing the controller gains

  %%  direct LMIs  
  A=[-1 1;1 -1];
  B=[1;1]
  Y = sdpvar(1,2);
  Q = sdpvar(2,2);
  
  L1 = Q > 0;
  L2 = Q*A' + A*Q + (B*Y)' + B*Y < 0;
  
  L = L1 + L2;
   optimize(L);
  Q = double(Q);
  Y = double(Y);
  K2 = Y*Q^-1; %computing the controller gains