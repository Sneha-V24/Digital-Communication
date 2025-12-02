clc; clear;close all;
N = 1000;
SNR_low = 24; 
SNR_high = -9;

% 1. BPSK
data = randi([0 1], N, 1);
bpsk_symbols = 2*data - 1;
figure;
subplot(1,3,1);
scatter(real(bpsk_symbols), imag(bpsk_symbols), 50, 'filled');
title('BPSK - Ideal'); grid on; axis([-2 2 -2 2]);
subplot(1,3,2);
bpsk_low = awgn(bpsk_symbols, SNR_low, 'measured');
scatter(real(bpsk_low), imag(bpsk_low), 50, 'filled');
title('BPSK - Low Noise'); grid on; axis([-2 2 -2 2]);
subplot(1,3,3);
bpsk_high = awgn(bpsk_symbols, SNR_high, 'measured');
scatter(real(bpsk_high), imag(bpsk_high), 50, 'filled');
title('BPSK - High Noise'); grid on; axis([-2 2 -2 2]);

% 2. QPSK
data = randi([0 3], N, 1);
qpsk_symbols = pskmod(data,4,pi/4);
figure;
subplot(1,3,1);
scatter(real(qpsk_symbols), imag(qpsk_symbols), 50, 'filled');
title('QPSK - Ideal'); grid on; axis([-2 2 -2 2]);
subplot(1,3,2);
qpsk_low = awgn(qpsk_symbols, SNR_low, 'measured');
scatter(real(qpsk_low), imag(qpsk_low), 50, 'filled');
title('QPSK - Low Noise'); grid on; axis([-2 2 -2 2]);
subplot(1,3,3);
qpsk_high = awgn(qpsk_symbols, SNR_high, 'measured');
scatter(real(qpsk_high), imag(qpsk_high), 50, 'filled');
title('QPSK - High Noise'); grid on; axis([-2 2 -2 2]);

% 3. 16-QAM
data = randi([0 15], N, 1);
qam_symbols = qammod(data,16);
figure;
subplot(1,3,1);
scatter(real(qam_symbols), imag(qam_symbols), 50, 'filled');
title('16-QAM - Ideal'); grid on; axis([-5 5 -5 5]);
subplot(1,3,2);
qam_low = awgn(qam_symbols, SNR_low, 'measured');
scatter(real(qam_low), imag(qam_low), 50, 'filled');
title('16-QAM - Low Noise'); grid on; axis([-5 5 -5 5]);
subplot(1,3,3);
qam_high = awgn(qam_symbols, SNR_high, 'measured');
scatter(real(qam_high), imag(qam_high), 50, 'filled');
title('16-QAM - High Noise'); grid on; axis([-5 5 -5 5]);
n; axis([-5 5 -5 5]);
subplot(1,3,3);
qam_high = awgn(qam_symbols, SNR_high, 'measured');
scatter(real(qam_high), imag(qam_high), 50, 'filled');
title('16-QAM - High Noise'); grid on; axis([-5 5 -5 5]);
