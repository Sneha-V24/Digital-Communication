clc; clear all; close all; 
fm = 5;
fs = 100;
A = 10;
delta = 3;
%Granular distortion delta = 0.5
%Slope distortion delta = 6
t = 0:1/fs:1/fm;
x = A*sin(2*pi*fm*t);
appr = zeros(1, length(x));
encoded = zeros(1, length(x));
for i = 1:length(x)-1
    if appr(i) < x(i)
        encoded(i) = 1;
        appr(i+1) = appr(i)+delta;
    else
        encoded(i) = 0;
        appr(i+1) = appr(i)-delta;
    end
end
figure;
subplot(221);plot(t,x);title('Original Message Signal');xlabel('Time'); ylabel('Amplitude');grid on;
subplot(222);stem(t,x);title('Sampled Signal');xlabel('Time'); ylabel('Amplitude');grid on;
subplot(223);plot(t,x); hold on;stairs(t, appr);title('DM Staircase Approximation');xlabel('Time'); ylabel('Amplitude');grid on;
subplot(224);stairs(t,encoded);title('Encoded signal');xlabel('Time (s)'); ylabel('Bit Value');grid on;ylim([-0.5 1.5]);
