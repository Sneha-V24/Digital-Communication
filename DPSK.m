% 1->Unchanged; 0->180 degrees phase shift
clc; clear; close all;
N = 5;
Rb = 100;
Tb = 1/Rb;
fc = 100;
fs = 10000;
tb = 0:1/fs:Tb-1/fs;
t = 0:1/fs:(Tb*N)-1/fs;
data = [1 0 1 1 0];
prev_encoded_bit = 1; 
dpsk_bits = [];
for i=1:length(data)
    current_data_bit = data(i);
    current_encoded_bit = not(xor(current_data_bit, prev_encoded_bit)); 
    dpsk_bits = [dpsk_bits, current_encoded_bit];
    prev_encoded_bit = current_encoded_bit; 
end
tx_signal = [];
phase = [0 pi]; 
for i=1:length(dpsk_bits)
    signal = cos(2*pi*fc*tb + phase(dpsk_bits(i)+1));
    tx_signal = [tx_signal, signal];
end
data_plot = repelem(data, length(tb));
dpsk_plot = repelem(dpsk_bits, length(tb));
subplot(311);stairs(t,data_plot);title('Message signal');xlabel('Time');ylabel('Amplitude');ylim([0 1.5]);grid on;ylim([-0.5 1.5]);
subplot(312);stairs(t, dpsk_plot); title('Encoded Signal (Standard DPSK)'); xlabel('Time'); ylabel('Amplitude');ylim([-0.5 1.5]);grid on;
subplot(313); plot(t, tx_signal); title('DPSK Modulated signal (Standard Encoding)'); xlabel('Time'); ylabel('Amplitude');grid on;ylim([-1.5 1.5]);
