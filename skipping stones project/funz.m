function ddz=funz(dx,z,dz,teta,mass)
M=mass;
p=1000;
g=9.8;
R=0.025;
% teta=pi/6;
B=atan(-dz/dx);
if abs(z)<2*R*sin(teta)&&z<0 
 ss=(1-(abs(z)/(R*sin(teta))));
 S=(R^2)*(acos(ss)-ss*sqrt(1-(ss)^2));
end
if abs(z)>2*R*sin(teta)&&z<0
    S=pi*(R^2);
end
if z>=0
    S=0;
end
% S=(0.1*abs(z))/sin(pi/6);

ddz=(-g)+(p/(2*M))*(dx^2+dz^2)*S*sin((teta)+B)*cos(teta);
end

