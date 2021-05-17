clc % Limpa Tela
disp('##############    (Opcional) -  Testa Equação do Calor   ###################')
format short 
format long


%M=10;
%N=1000;
%k1=10;
%k2=5;
%w1 = heatfd(0,1,0,0.5,M,N);

%w1(:,N+1)

%w2 = heatbd(0,1,0,0.5,M*k1,N*k1);

%w3 = crank(0,1,0,0.5,M,N);

%w4 = crank(0,1,0,0.5,M*k1,N*k1);

%w5 = crank(0,1,0,0.5,M*k2,N*k2);

%R =[ w1(:,N+1) w2(1:k1:M*k1+1,N*k1+1) w3(:,N+1)  w4(1:k1:M*k1+1,N*k1+1)   w5(1:k2:M*k2+1,N*k2+1)]
%function [w]=burgers(xl,xr,tb,te,h,k) 
%[w1, Sol]=burgers(0,0.5,0,2, 0.01,0.04);
%[w2, Sol]=burgers(0,0.5,0,2, 0.01,0.02);
%[w3, Sol]=burgers(0,0.5,0,2, 0.01,0.01);
%  0.155112413275401
%[M1,N1]=size(w1)
%[M2,N2]=size(w2)
%[M3,N3]=size(w3)
%R = [Sol(M1) w1(M1,N1) w2(M2,N2) w3(M3,N3)]
 
%function [w,Sol]=burgers(eq,alfa,beta,v,xl,xr,tb,te,M,N);
  
 [w1,Sol]=burgers(1,5,4,0.05,0,1,0,1,0.01,0.040);  
 [w2,Sol]=burgers(1,5,4,0.05,0,1,0,1,0.01,0.020);  
 [w3,Sol]=burgers(1,5,4,0.05,0,1,0,1,0.01,0.010);  
 [w4,Sol]=burgers(1,5,4,0.05,0,1,0,1,0.01,0.005); 
  
 t1=size(w1)
 t2=size(w2)
 t3=size(w3)
 t4=size(w4)

 L1 = [ w1(51,26) w2(51,51) w3(51,101) w4(51,201)];
 L2 = [ Sol Sol Sol Sol];
 Tabela__Valor_Aprox__________Exato_____________Erro= [ L1' L2' (L1-L2)']

 
 [w5,Sol]=burgers(2,2,4,0.05,0,1,0,1,0.010,0.0400); 
 [w6,Sol]=burgers(2,2,4,0.05,0,1,0,1,0.010,0.0100);
 [w7,Sol]=burgers(2,2,4,0.05,0,1,0,1,0.010,0.0025);
 [w8,Sol]=burgers(2,2,4,0.05,0,1,0,1,0.010,0.0005); 
  
 t5=size(w5)
 t6=size(w6)
 t7=size(w7)
 t8=size(w8)

 L3 = [ w5(51,26) w6(51,101) w7(51,401) w8(51,2001)];
 L4 = [ Sol Sol Sol Sol];
 Tabela__Valor_Aprox__________Exato_____________Erro= [ L3' L4' (L3-L4)']

 