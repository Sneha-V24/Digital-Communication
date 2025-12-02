clc; clear; close all;
Rb = 1000;          
Tb = 1/Rb;          
Fs = 100000;          
fc = 1000;    
bits = [0 0 1 0 0 1 1 1]; % Example bits
numbits = length(bits);
t_bit = 0:1/Fs:Tb-1/Fs;
digital_signal_qpsk = repelem(bits, length(t_bit));
t_digital_qpsk = 0:1/Fs:Tb*numbits - 1/Fs;
I_bits = bits(1:2:end);
Q_bits = bits(2:2:end);
numSymbols = length(I_bits);
I_symbols = 2*I_bits - 1;
Q_symbols = 2*Q_bits - 1;
I_baseband = [];
Q_baseband = [];
qpsk_modulated = [];
for k = 1:numSymbols
    t = (k-1)*2*Tb : 1/Fs : k*2*Tb - 1/Fs;
    I_baseband = [I_baseband I_symbols(k)*ones(1,length(t))];
    Q_baseband = [Q_baseband Q_symbols(k)*ones(1,length(t))];
    I_carrier = I_symbols(k) * cos(2*pi*fc*t);
    Q_carrier = Q_symbols(k) * sin(2*pi*fc*t);
    qpsk_modulated = [qpsk_modulated I_carrier + Q_carrier];
end
t_qpsk = 0:1/Fs:length(qpsk_modulated)/Fs - 1/Fs;
subplot(4,1,1);plot(t_digital_qpsk, digital_signal_qpsk);title('QPSK: Original Digital Signal');xlabel('Time'); ylabel('Amplitude');grid on;ylim([-0.5 1.5]);
subplot(4,1,2);plot(t_qpsk, (I_baseband+1)/2);title('QPSK: Baseband In-phase Component');xlabel('Time'); ylabel('Amplitude');grid on;ylim([-0.5 1.5]);
subplot(4,1,3);plot(t_qpsk, (Q_baseband+1)/2);title('QPSK: Baseband Quadrature Component');xlabel('Time'); ylabel('Amplitude');grid on;ylim([-0.5 1.5]);
subplot(4,1,4);plot(t_qpsk, qpsk_modulated);title('QPSK: Modulated Signal');xlabel('Time'); ylabel('Amplitude');grid on;
