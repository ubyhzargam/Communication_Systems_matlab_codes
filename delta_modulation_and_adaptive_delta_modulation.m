%% Delta Modulation 

clc;
close all;

a=2;
t=0:2*pi/50:2*pi;
x=a*sin(t);
l=length(x);
plot(x,'r');
delta=0.2;

hold on
xn=0;

for i=1:l
    if(x(i)>xn(i))
        d(i)=1;
        xn(i+1)=xn(i)+delta;
    else
    d(i)=0;
    xn(i+1)=xn(i)-delta;
    end
end
stairs(xn);
hold on;
legend('Analog signal','DM with step size=0.2')
title('DELTA MODULATION')

%% Adaptive Delta Modulation
clc;
close all;
td=0.01;
ts=0.02;
t=0:td:5;
x=8*sin(2*pi*t);
delta=0.1;
figure(1);
plot(t,x);
ADMout=adeltamod(x,delta,td,ts);
figure(2);
plot(t,ADMout);

function [ADMout]=adeltamod(sig_in,delta,td,ts)
if(round(ts/td)>=2)
    Nfac=round(ts/td);
    xsig=downsample(sig_in,Nfac);
    Lxsig=length(xsig);
    Lxin=length(sig_in);

    ADMout=zeros(Lxin);

    cnt1=0;
    cnt2=0;
    sum=0;

    for i=1:Lxsig

        if(xsig(i)==sum)
        elseif(xsig(i)>sum)
            if(cnt1<2)
                sum=sum+delta;
            elseif(cnt1==2)
                sum=sum+2*delta;
            elseif(cnt1==3)
                sum=sum+4*delta;
            else
                sum=sum+8*delta;
            end
            if(sum<xsig(i))
                cnt1=cnt1+1;
            else
                cnt1=0;
            end
        else
            if(cnt2<2)
                sum=sum-delta;
            elseif(cnt2==2)
                sum=sum-2*delta;
            elseif(cnt2==3)
                sum=sum-4*delta;
            else
                sum=sum-8*delta;
            end
            if(sum>xsig(i))
                cnt2=cnt2+1;
            else
                cnt2=0;
            end
        end
        ADMout(((i-1)*Nfac+1):(i*Nfac))=sum;
    end
end
end
