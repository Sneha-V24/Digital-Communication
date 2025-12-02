clc; clear; close all;
Rb=1000;
Tb=1/Rb;
Fs=100000;
fc=1000;
bits_qam=[0 1 1 0 0 1 0 1 1 1 1 1 1 0 1 0];
numBits_qam=length(bits_qam);
t_bit=0:1/Fs:Tb-1/Fs;
digital_signal_qam=repelem(bits_qam,length(t_bit));
t_digital_qam=0:1/Fs:Tb*numBits_qam-1/Fs;
grayMap=containers.Map({'00','01','11','10'},[-3 -1 1 3]);
symbols=reshape(bits_qam,4,[]).';
numSymbols_qam=size(symbols,1);
I_baseband=[];
Q_baseband=[];
qam_modulated=[];
for k=1:numSymbols_qam
    I_bits_str=sprintf('%d%d',symbols(k,1),symbols(k,2));
    Q_bits_str=sprintf('%d%d',symbols(k,3),symbols(k,4));
    I_amp=grayMap(I_bits_str);
    Q_amp=grayMap(Q_bits_str);
    t=(k-1)*4*Tb:1/Fs:k*4*Tb-1/Fs;
    I_baseband=[I_baseband I_amp*ones(1,length(t))];
    Q_baseband=[Q_baseband Q_amp*ones(1,length(t))];
    I_carrier=I_amp*cos(2*pi*fc*t);
    Q_carrier=Q_amp*sin(2*pi*fc*t);
    qam_modulated=[qam_modulated I_carrier+Q_carrier];
end
t_qam=0:1/Fs:length(qam_modulated)/Fs-1/Fs;
figure('Name','16-QAM Modulation');
subplot(4,1,1);plot(t_digital_qam,digital_signal_qam);title('16-QAM: Original Digital Signal');xlabel('Time (s)');ylabel('Amplitude');grid on;ylim([-0.5 1.5]);
subplot(4,1,2);plot(t_qam,I_baseband);title('16-QAM: In-phase (I) Component');xlabel('Time (s)');ylabel('Amplitude');grid on;ylim([-4 4]);
subplot(4,1,3);plot(t_qam,Q_baseband);title('16-QAM: Quadrature (Q) Component');xlabel('Time (s)');ylabel('Amplitude');grid on;ylim([-4 4]);
subplot(4,1,4);plot(t_qam,qam_modulated);title('16-QAM: Modulated Signal');xlabel('Time (s)');ylabel('Amplitude');grid on;

