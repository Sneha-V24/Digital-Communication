clc; clear; close all;
rb = 100;
T = 1 / rb;
N = 5;
bits = [1 0 1 1 0];
samples_per_bit = 200;
Vp = 1;
NRZ_out = [];
for index = 1:N
    if bits(index) == 1
        NRZ_out = [NRZ_out ones(1, samples_per_bit) * Vp];
    else
       NRZ_out = [NRZ_out ones(1, samples_per_bit) * (-Vp)];
    end
end
total_samples = length(NRZ_out);
t = (0:total_samples-1) * (T / samples_per_bit);
f = 1000;
carrier_signal = sqrt(2/T) * cos(2 * pi * f * t);
Modulated = NRZ_out .* carrier_signal;
SNR_dB = 0.1;
noisy_signal = awgn(Modulated, SNR_dB, 'measured');
%signal_power = mean(Modulated.^2);
%noise_power = signal_power / (10^(SNR_dB/10));
%noise = sqrt(noise_power) * randn(size(Modulated));
%noisy_signal = Modulated + noise;
received_signal = noisy_signal .* carrier_signal;
decoded_bits = zeros(1, N);
for k = 1:N
    start_idx = (k-1)*samples_per_bit + 1;
    end_idx = k*samples_per_bit;
    bit_energy = sum(received_signal(start_idx:end_idx));
    decoded_bits(k) = bit_energy > 0;
end
subplot(5, 1, 1);plot(t, NRZ_out);xlabel('Time');ylabel('Amplitude');title('Generated NRZ signal');grid on;ylim([-1.5 1.5]);
subplot(5, 1, 2);plot(t, Modulated);xlabel('Time');ylabel('Amplitude');title('BPSK Modulated signal');grid on;
subplot(5, 1, 3);plot(t,noisy_signal);xlabel('Time');ylabel('Amplitude');title('Received Noisy Signal');grid on;
subplot(5, 1, 4);plot(t,received_signal);xlabel('Time');ylabel('Amplitude');title('Demodulated Signal');grid on;
subplot(5, 1, 5);stairs(0:T:N*T, [decoded_bits decoded_bits(end)]);xlabel('Time');ylabel('Decoded Bits (0 or 1) ');title('Demodulated Bits (Coherent Detection)');xlim([0 N*T]);grid on;ylim([-0.5 1.5]);

