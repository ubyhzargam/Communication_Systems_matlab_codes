%% Sampling plots in Time domain

clc;
close all;

tfinal=0.01;
t=0:0.00001:tfinal;

xanalog=cos(2*pi*400*t)+cos(2*pi*700*t);

figure;
subplot(4,1,1);
plot(xanalog,'r-');
title("The original Analog signal");
xlabel("Time");
ylabel("Magnitude");

%Critical Sampling (fs=2*fm)
fs=1400;
t1=0:1/fs:tfinal;
xsignal=cos(2*pi*400*t1)+cos(2*pi*700*t1);
subplot(4,1,2);
plot(xsignal,'b*-');
title("Critical Sampling of Analog Signal");
xlabel("Time");
ylabel("Magnitude");

%Under Sampling (fs<2*fm)
fs=700;
t1=0:1/fs:tfinal;
xsignal=cos(2*pi*400*t1)+cos(2*pi*700*t1);
subplot(4,1,3);
plot(xsignal,'b*-');
title("Under Sampling of Analog Signal");
xlabel("Time");
ylabel("Magnitude");

%Over Sampling (fs>2*fm)
fs=2000;
t1=0:1/fs:tfinal;
xsignal=cos(2*pi*400*t1)+cos(2*pi*700*t1);
subplot(4,1,4);
plot(xsignal,'b*-');
title("Over Sampling of Analog Signal");
xlabel("Time");
ylabel("Magnitude");

%% Sampling plots in frequency domain

clc;
close all;

tfinal=0.01;
t=0:0.00001:tfinal;

xanalog=cos(2*pi*400*t)+cos(2*pi*700*t);

figure;
subplot(4,1,1);
stem(fftshift(abs(fft(xanalog))),'r-');
title("The frequency plot of the original signal ");
xlabel("Frequency");
ylabel("Magnitude");

%Critical Sampling (fs=2*fm)
fs=1400;
t1=0:1/fs:tfinal;
xsignal=cos(2*pi*400*t1)+cos(2*pi*700*t1);
subplot(4,1,2);
stem(fftshift(abs(fft(xsignal))),'b-');
title("Frequecny plot of Critical Sampling of Analog Signal");
xlabel("Frequency");
ylabel("Magnitude");

%Under Sampling (fs<2*fm)
fs=700;
t1=0:1/fs:tfinal;
xsignal=cos(2*pi*400*t1)+cos(2*pi*700*t1);
subplot(4,1,3);
stem(fftshift(abs(fft(xsignal))),'b-');
title("Frequecny plot of Under Sampling of Analog Signal");
xlabel("Frequency");
ylabel("Magnitude");

%Over Sampling (fs>2*fm)
fs=20000;
t1=0:1/fs:tfinal;
xsignal=cos(2*pi*400*t1)+cos(2*pi*700*t1);
subplot(4,1,4);
stem(fftshift(abs(fft(xsignal))),'b-');
title("Frequecny plot of Over Sampling of Analog Signal");
xlabel("Frequency");
ylabel("Magnitude");
