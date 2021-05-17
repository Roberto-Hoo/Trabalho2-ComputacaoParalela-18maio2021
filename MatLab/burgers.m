% Program 8.7 Implicit Newton solver for Burgers equation
% input: space interval [xl,xr], time interval [tb,te],
%        number of space steps M, number of time steps N
% output: solution w
% Example usage: w=burgers(0,1,0,2,20,40)
function [w,Sol]=burgers(eq,alfa,beta,v,xl,xr,tb,te,M,N);
%alfa=5;
%beta=4;
%v=0.05;
f3 = @(x) sin(pi*x); 
f1 = @(x) 2*v*beta*pi*sin(pi*x)./(alfa+beta*cos(pi*x));
s1 = @(x,t) 2*v*beta*pi*sin(pi*x)*exp(-v*t*pi^2)./(alfa+beta*cos(pi*x)*exp(-v*t*pi^2));
s2 = @(x,t) 2*pi*v*sin(pi*x)*exp(-v*t*pi^2)./(alfa+cos(pi*x)*exp(-v*t*pi^2));
%s(0.5,1)
l=@(t) 0*t;
r=@(t) 0*t;
if  M > 1
    h=(xr-xl)/M;
    k=(te-tb)/N;
else
    h = M;
    k = N;
    M=(xr-xl)/h;
    N=(te-tb)/k;
end
%M;
%N;
%h;
%k;
sigma=v*k/(h*h);
if (eq == 1)
    w(:,1)=s1(xl+(0:M)*h,0)'; % initial conditions    
    Sol=s1(0.5,1); % solução exata
end
if (eq == 2)
    w(:,1)=s2(xl+(0:M)*h,0)'; % initial conditions    
    Sol=s2(0.5,1); % solução exata
end
if (eq == 3)
    w(:,1)=f3(xl+(0:M)*h)'; % initial conditions    
    Sol= -123456789; % solução exata
end

w1=w;
size_w = size(w);
for j=1:N
    for it=1:6 % Newton iteration
        DF1=zeros(M+1,M+1);
        DF2=zeros(M+1,M+1);
        %Derivadas do polinomio de grau 1
        DF1=diag(1+2*sigma*ones(M+1,1))+diag(-sigma*ones(M,1),1);
        DF1=DF1+diag(-sigma*ones(M,1),-1);
        %DF1
        %J1=[0;k*w1(3:M+1)/(2*h);0]
        %J2=diag([0;k*w1(3:M+1)/(2*h);0])
        %J3=[0;k*w1(1:(M-1))/(2*h);0]
        %J4=diag([0;k*w1(1:(M-1))/(2*h);0])
        %J5=w1(3:M+1)
        %Derivadas do polinômio de grau 2
        DF2=diag([0;k*w1(3:M+1)/(2*h);0])-diag([0;k*w1(1:(M-1))/(2*h);0]);
        DF2=DF2+diag([0;k*w1(2:M)/(2*h)],1)-diag([k*w1(2:M)/(2*h);0],-1);
        %DF2
        DF=DF1+DF2;
        %Fi(z1,...,zm) = zi + (k/2h)zi(zi+1 ? zi?1) ? ?(zi+1 ? 2zi + zi?1) ? wi,j?1 = 0
        F=-w(:,j)+(DF1+DF2/2)*w1; % Using Lemma 8.11
        DF(1,:)=[1 zeros(1,M)]; % Dirichlet conditions for DF
        DF(M+1,:)=[zeros(1,M) 1];
        %w1_1=w1(1);
        %w1_M_1=w1(M+1);
        F(1)= w1(1)-l(j);
        F(M+1)= w1(M+1)-r(j); % Dirichlet conditions for F
        F;
        %S = DF\F;
        w1=w1-DF\F;
    end
    w(:,j+1)=w1;
end
%w
x=xl+(0:M)*h;
t=tb+(0:N)*k;
figure(40);
mesh(x,t,w')
