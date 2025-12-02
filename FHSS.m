clc; clear; close all;
bin = input('Enter the input bits (e.g. [1 0 1 0 1]): ');
b = 2*bin - 1;
Fs = 10000;
Tb = 0.01;
t = 0:1/Fs:Tb;
freqs = [500 1000 1500 2000 2500 3000 3500 4000];
hop_pattern = randi(length(freqs), 1, length(b));
subplot(4,1,1);
stairs(b, 'LineWidth', 2);
xlabel('Bit Index'); ylabel('Amplitude');
title('INPUT BIT SEQUENCE b(t)');
subplot(4,1,2);
stairs(hop_pattern, 'LineWidth', 2);
xlabel('Bit Index'); ylabel('Frequency Index');
title('FREQUENCY HOPPING PATTERN');
fhss = [];
for i = 1:length(b)
    f = freqs(hop_pattern(i));
    if b(i) == 1
        sig = sin(2*pi*f*t);
    else
        sig = sin(2*pi*f*t + pi);
    end
    fhss = [fhss sig];
end
subplot(4,1,3);
plot((0:length(fhss)-1)/Fs, fhss, 'r', 'LineWidth', 1.2);
xlabel('Time (s)'); ylabel('Amplitude');
title('FHSS MODULATED SIGNAL');
