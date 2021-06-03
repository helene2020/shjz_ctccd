clc
close all;
x=35:65;
y=-5:5;
z=2:4;
x0=0:1:100;
y0=0.5;
z0=0.0;
c=1;
ro=10;
pi=3.1415926;
c_a=c/((length(x)-1)*(length(y)-1)*(length(z)-1));
xi=x+0.5;
yi=y+0.5;
zi=z+0.5;
xs=35;%35为非对称模型；50为对称模型
ys=0;
zs=3;

ii=1;
rmax=0.0;
for j=1:length(xi)-1;
        dx=(xi(j)/100-xs/100)*(xi(j)/100-xs/100);
        for k=1:length(yi)-1;
           dy=(yi(k)/100-ys/100)*(yi(k)/100-ys/100); 
            for l=1:length(zi)-1;
             dz=(zi(l)/100-zs/100)*(zi(l)/100-zs/100);
             r=sqrt(dx+dy+dz);
             rjc(ii)=r;
              if(1/r>=rmax)
                  rmax=1/r;
              end
       
             ii=ii+1;
            end
        end
end
% cc=cc/(rmax*2.); %对称模型
% cc=cc/rmax; %非对称模型
if xs<=50
cc=cc/rmax*abs((xs-65)/30);
else
cc=cc/rmax*abs((xs-35)/30);
end

for i=1:length(x0);
    u=0;ii=1;dux=0;
    for j=1:length(xi)-1;
        dx=(xi(j)/100-x0(i)/100)*(xi(j)/100-x0(i)/100);
        for k=1:length(yi)-1;
           dy=(yi(k)/100-y0/100)*(yi(k)/100-y0/100); 
            for l=1:length(zi)-1;
             dz=(zi(l)/100-z0/100)*(zi(l)/100-z0/100);
    
             r=sqrt(dx+dy+dz);
             u=u+cc(ii)*ro/(2*pi*r);
             dux=dux+cc(ii)*ro*(xi(j)/100-x0(i)/100)/(2*pi*r^3);
             ii=ii+1;
            end
        end
    end
    up(i)=u;dup(i)=dux/120;
end

figure;
% plot(x0,up,'r',x0,dup,'r');
subplot(1,2,1);plot(x0,up,'r');
subplot(1,2,2);plot(x0,dup,'r');
sc=[up' dup'];

save xhjz.dat -ascii sc;



    