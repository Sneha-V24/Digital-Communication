clc;clear;close all;
rb=100;
T=1/rb;
N=5;
bits=[1 0 1 1 0];
samples_per_bit=200;
total_samples=N*samples_per_bit;
t=(0:total_samples-1)*(T/samples_per_bit);
bit_levels=[];
for k=1:N
    if bits(k)==1
        bit_levels=[bit_levels ones(1,samples_per_bit)];
    else
        bit_levels=[bit_levels zeros(1,samples_per_bit)];
    end
end
f1=500;f2=1000;
Modulated=zeros(1,total_samples);
for k=1:N
    start_idx=(k-1)*samples_per_bit+1;
    end_idx=k*samples_per_bit;
    if bits(k)==1
        Modulated(start_idx:end_idx)= sqrt(2/T)*cos(2*pi*f2*t(start_idx:end_idx));
    else
        Modulated(start_idx:end_idx)=sqrt(2/T)*cos(2*pi*f1*t(start_idx:end_idx));
    end
end
SNR_dB=0.1;
noisy_signal=awgn(Modulated,SNR_dB,'measured');
received_signal1=noisy_signal.*cos(2*pi*f1*t);
received_signal2=noisy_signal.*cos(2*pi*f2*t);
demodulated_signal=received_signal2-received_signal1;
decoded_bits=zeros(1,N);
for k=1:N
    start_idx=(k-1)*samples_per_bit+1;
    end_idx=k*samples_per_bit;
    energy_f1=sum(received_signal1(start_idx:end_idx));
    energy_f2=sum(received_signal2(start_idx:end_idx));
    decoded_bits(k)=energy_f2>energy_f1;
end
subplot(5,1,1);stairs(0:T:N*T,[bits bits(end)]);xlabel('Time');ylabel('Bit Level');title('Input Bits');xlim([0 N*T]);grid on;ylim([-1.5 1.5]);
subplot(5,1,2);plot(t,Modulated);xlabel('Time');ylabel('Amplitude');title('BFSK Modulated Signal');grid on;
subplot(5,1,3);plot(t,noisy_signal);xlabel('Time');ylabel('Amplitude');title('Received Noisy Signal');grid on;
subplot(5,1,4);plot(t,demodulated_signal);xlabel('Time');ylabel('Amplitude');title('Demodulated Signal');grid on;
subplot(5,1,5);stairs(0:T:N*T,[decoded_bits decoded_bits(end)]);xlabel('Time');ylabel('Decoded Bits');title('Demodulated Bits');xlim([0 N*T]);grid on;ylim([-0.5 1.5]);

