clc;
close all;

t=-5:0.01:5;

f=2;
w=2*pi*f;
osr=250;
fs1=w/pi;
fs=fs1*osr;

ts=-5:1/fs:5;
y=@(t)sin(w.*t);

[u,q]=SDQ(y(ts),ts);

z=0;
for k=1:length(ts)
    z=z+q(k).*sinc(w.*(t-ts(k)));
end
c=max(y(t))./max(z);
z=z.*c;

figure(1)
subplot(3,1,1)
plot(t,y(t),'linewidth',2)
title('Original sinal')
xlabel('Time')
ylabel('Amplitude')
subplot(3,1,2)
plot(ts,q)
title('SDQ signal');
xlabel('Time');
ylabel('Amplitude');
subplot(3,1,3)
plot(t,z,'linewidth',2);
title('Reconstructed signal');
xlabel('Time');
ylabel('Amplitude');
figure(2);
plot(t,y(t),'linewidth',2)
hold on
plot(t,z,'linewidth',2);
title('Original vs Reconstructed');
figure(3);
plot(abs(z - y(t)),'linewidth',2);
title('Error');
figure(4);
subplot(3,1,1);
plot(abs(fftshift(fft(y(t)))));
xlabel('Frequency');
ylabel('Amplitude');
title('Spectrum of original signal');
subplot(3,1,2);
plot(abs(fftshift(fft(q))));
xlabel('Frequency');
ylabel('Amplitude');
title('Spectrum of SDQ');
subplot(3,1,3);
plot(abs(fftshift(fft(z))));
title('Spectrum of recovered signal');
xlabel('Frequency');
ylabel('Amplitude');

error=immse(z,y(t));

function [u,q] = SDQ(y,t)

q = zeros(1,length(t));
u = zeros(1,length(t)); 
u(1) = 0.9; 
for k = 2:length(t)
q(k) = sign(u(k-1) + y(k));
u(k) = u(k-1) + y(k) - q(k);
end
end