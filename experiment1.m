%Autocorrelation of function 
echo on;
N=1000;
M=75; %represents lags

Rx_av=zeros(1,M+1);
Sx_av=zeros(1,M+1);

for j=1:10

    X=rand(1,N)-1/2;
    Rx=Rx_est(X,M);
    Sx=fftshift(abs(fft(Rx)));
    Rx_av=Rx_av+Rx;
    Sx_av=Sx_av+Sx;
    echo off;

end

echo on;

Rx_av=Rx_av/10;
Sx_av=Sx_av/10;

figure;
subplot(2,1,1);
plot(Rx_av);
title("Ensemble Average of autocorrelation of X");
ylabel("Magnitude");
xlabel("lag");

subplot(2,1,2);
plot(Sx_av);
title("Ensemble average of power spectral density");
ylabel("Magnitude");
xlabel("Frequency");

figure;
subplot(2,1,1);
Sxy=fftshift(abs(fft(Sx_av)));
plot(Sxy);
title("FFT of Ensemble average of autocorrelation");
xlabel("Frequency");
ylabel("Magnitude");

subplot(2,1,2);
xy=fftshift(abs(fft(Rx_av)));
plot(xy);
title("FFT of Ensemble average of power density");
xlabel("Frequency");
ylabel("Magnitude");


%% Low Pass 

N=1000;
M=75;

Rx_av=zeros(1,M+1);
Sx_av=zeros(1,M+1);
Ry_av=zeros(1,M+1);
Sy_av=zeros(1,M+1);

for j=1:10
    X=rand(1,N)-1/2;
    Y(1)=0;
    for n=2:N
        Y(n)=0.9*Y(n-1)+X(n);
    end
    Rx=Rx_est(X,M);
    Sx=fftshift(abs(fft(Rx)));
    Ry=Rx_est(Y,M);
    Sy=fftshift(abs(fft(Ry)));

    Rx_av=Rx_av+Rx;
    Ry_av=Ry+Ry_av;
    Sx_av=Sx+Sx_av;
    Sy_av=Sy+Sy_av;
    echo off;

end

Rx_av=Rx_av/10;
Ry_av=Ry_av/10;
Sx_av=Sx_av/10;
Sy_av=Sy_av/10;

figure;
subplot(2,1,1);
plot(Rx_av);
title("Plot of autocorrelation of X");
xlabel("lags");
ylabel("Magnitude");

subplot(2,1,2);
plot(Ry_av);
title("Plot of autocorrelation of Y");
xlabel("lags");
ylabel("Magnitude");

figure;
subplot(2,1,1);
plot(Sx_av);
title('Plot of power spectral density of X');
xlabel("Frequency");
ylabel("Magnitude");

subplot(2,1,2);
plot(Sy_av);
title("Plot of power spectral density of Y");
xlabel("Frequency");
ylabel("Magnitude");

%% BandPass

N=1000;

X1=zeros(1,N);
X2=zeros(1,N);

m=0;
sgma=1; %this is the standard deviation

for i=1:2:N
    [X1(i),X1(i+1)]=gngauss(m,sgma);
    [X2(i),X2(i+1)]=gngauss(m,sgma);
end

A=[1,-0.9];
B=1;

Xc=filter(B,A,X1);
Xs=filter(B,A,X2);

band_pass_process=zeros(1,N);

fc=1000/pi;
M=50; %defines lag

for i=1:N
    band_pass_process(i)=Xc(i)*cos(2*pi*fc*i)+Xs(i)*sin(2*pi*fc*i);
end

autocorr=Rx_est(band_pass_process,M);
power_sd=fftshift(abs(fft(autocorr)));

figure;
subplot(2,1,1);
plot(0:M,autocorr,'Display','Autocorrelation');
title("Autocorrelation of bandpass process");
ylabel("Magnitude");
xlabel("Time");

subplot(2,1,2);
frequencies=linspace(-0.5,0.5,M+1);
plot(frequencies,power_sd);
title("PSD of bandpass process");
ylabel("Magnitude");
xlabel("Frequency");

function[gsrv1,gsrv2]=gngauss(m,sgma)
u=rand;
z=sgma*(sqrt(2*log(1/(1-u))));
u =rand;
gsrv1=m+z*cos(2*pi*u);
gsrv2=m+z*sin(2*pi*u);
end

function [Rx] = Rx_est(X,M)
N=1000;
Rx=zeros(1,M+1);
for m=1:M+1
    for n=1:N-m+1
        Rx(m)=Rx(m)+X(n)*X(m+n-1);
    end
    Rx(m)=Rx(m)/(N-m+1);
end
end

