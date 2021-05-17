function [w,Sol]=burgers(eq,alfa,beta,v,xl,xr,tb,te,M,N);
f1 = @(x) 2*v*beta*pi*sin(pi*x)./(alfa+beta*cos(pi*x));
s1 = @(x,t) 2*v*beta*pi*sin(pi*x)*exp(-v*t*pi^2)./(alfa+beta*cos(pi*x)*exp(-v*t*pi^2));
l=@(t) 0*t;  r=@(t) 0*t;
sigma=v*k/(h*h);  w1=w;
for j=1:N
    for it=1:6 % Newton iteration
        DF1=zeros(M+1,M+1);
        DF2=zeros(M+1,M+1);       
        DF1=diag(1+2*sigma*ones(M+1,1))+diag(-sigma*ones(M,1),1); %Derivadas do polinomio de grau 1
        DF1=DF1+diag(-sigma*ones(M,1),-1);        
        DF2=diag([0;k*w1(3:M+1)/(2*h);0])-diag([0;k*w1(1:(M-1))/(2*h);0]); %Derivadas do polinômio de grau 2
        DF2=DF2+diag([0;k*w1(2:M)/(2*h)],1)-diag([k*w1(2:M)/(2*h);0],-1);       
        DF=DF1+DF2;       
        F=-w(:,j)+(DF1+DF2/2)*w1; % Using Lemma 8.11
        DF(1,:)=[1 zeros(1,M)]; % Dirichlet conditions for DF
        DF(M+1,:)=[zeros(1,M) 1];        
        F(1)= w1(1)-l(j);
        F(M+1)= w1(M+1)-r(j); % Dirichlet conditions for F       
        w1=w1-DF\F;
    end
    w(:,j+1)=w1;
end
x=xl+(0:M)*h;  t=tb+(0:N)*k;   figure(40);  mesh(x,t,w')
