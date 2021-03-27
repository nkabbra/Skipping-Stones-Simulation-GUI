
function [t,x,z]=RK4(funx,funz,x0,dx0,z0,dz0,a,b,N,angle,M)
h=0.01;
t(1)=a;
x(1)=x0;
dx(1)=dx0;
z(1)=z0;
dz(1)=dz0;
for k=1:N
    t(k+1)=a+k*h;
   k1dx=feval(funx,dx(k),z(k),dz(k),angle,M);
   k1x=dx(k);
   k1dz=feval(funz,dx(k),z(k),dz(k),angle,M);
   k1z=dz(k);
   
    k2dx=feval(funx,dx(k)+0.5*h*k1dx,z(k)+0.5*h*k1z,dz(k)+0.5*h*k1dz,angle,M);
    k2x=dx(k)+0.5*h*k1dx;
    k2dz=feval(funz,dx(k)+0.5*h*k1dz,z(k)+0.5*h*k1z,dz(k)+0.5*h*k1dz,angle,M);
    k2z=dz(k)+0.5*h*k1dz;
    
    k3dx=feval(funx,dx(k)+0.5*h*k2dx,z(k)+0.5*h*k2z,dz(k)+0.5*h*k2dz,angle,M);
    k3x=dx(k)+0.5*h*k2dx;
    k3dz=feval(funz,dx(k)+0.5*h*k2dz,z(k)+0.5*h*k2z,dz(k)+0.5*h*k2dz,angle,M);
    k3z=dz(k)+0.5*h*k2dz;
    
    
    k4dx=feval(funx,dx(k)+h*k3dx,z(k)+h*k3z,dz(k)+h*k3dz,angle,M);
    k4x=dx(k)+h*k3dx;
    k4dz=feval(funz,dx(k)+h*k3dz,z(k)+h*k3z,dz(k)+h*k3dz,angle,M);
    k4z=dz(k)+h*k3dz;
   
    
    dx(k+1)=dx(k)+(1/6)*(k1dx+2*k2dx+2*k3dx+k4dx)*h;
    x(k+1)=x(k)+(1/6)*(k1x+2*k2x+2*k3x+k4x)*h;
   dz(k+1)=dz(k)+(1/6)*(k1dz+2*k2dz+2*k3dz+k4dz)*h;
    z(k+1)=z(k)+(1/6)*(k1z+2*k2z+2*k3z+k4z)*h
   
    
end
end



