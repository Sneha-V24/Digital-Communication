clc; clear; close all;
bin = [1 0 1 1 0];
b = 2*bin - 1;
Fs = 10000;
Tb = 0.01;
tbit = 0:1/Fs:Tb;
f = 200;
slots = 8;
thss = zeros(1, length(b)*slots*length(tbit));
hop = randi(slots, 1, length(b));
t = 0:1/Fs:(length(thss)-1)/Fs;
subplot(4,1,1)
stairs(b, 'LineWidth', 2)
xlabel('Bit Index'); ylabel('Amplitude')
title('INPUT BIT SEQUENCE')
subplot(4,1,2)
stairs(hop, 'LineWidth', 2)
xlabel('Bit Index'); ylabel('Time Slot')
title('TIME HOPPING PATTERN')
for i = 1:length(b)
    start = (hop(i)-1)*length(tbit) + (i-1)*slots*length(tbit) + 1;
    stop = start + length(tbit) - 1;
    if b(i) == 1
        thss(start:stop) = sin(2*pi*f*tbit);
    else
        thss(start:stop) = sin(2*pi*f*tbit + pi);
    end
end
subplot(4,1,3)
plot(t, thss, 'r', 'LineWidth', 1.2)
xlabel('Time (s)'); ylabel('Amplitude')
title('THSS MODULATED SIGNAL')

