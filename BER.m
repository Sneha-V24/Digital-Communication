clc;clear;close all;
N = 100000; 
SNR_dB = -4:1:10; 
M = input('Enter M (e.g. 2 for BPSK, 8 for 8-PSK): ');
k = log2(M); 
data = randi([0 M-1], N, 1);
txSig = pskmod(data, M, 0, 'gray'); 
ber_sim = zeros(size(SNR_dB));
ber_theory = zeros(size(SNR_dB));
for i = 1:length(SNR_dB)
 rxSig = awgn(txSig, SNR_dB(i), 'measured');
 rxData = pskdemod(rxSig, M, 0, 'gray');
 [~, ber_sim(i)] = biterr(de2bi(data,k), de2bi(rxData,k));
 EbN0 = 10^(SNR_dB(i)/10); 
 if M == 2
 ber_theory(i) = qfunc(sqrt(2*EbN0));
 else 
 ber_theory(i) = (2/k) * qfunc(sqrt(2*k*EbN0) * sin(pi/M));
 end
end
semilogy(SNR_dB, ber_sim, 'mo-','LineWidth',1.5); hold on;
semilogy(SNR_dB, ber_theory, 'b-','LineWidth',1.5);
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title(sprintf('BER Performance of %d-PSK', M));
legend('Simulated','Theoretical','Location','southwest');

