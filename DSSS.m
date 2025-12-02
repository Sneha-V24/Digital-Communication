    clc; clear; close all;
bin = input('Enter the input bits (e.g. [1 0 1 0 1]): ');
b = 2*bin - 1;
bb = repelem(b, 8);
len = length(bb);
subplot(4,1,1);
stairs(bb, 'LineWidth', 2);
xlabel('Time'); ylabel('Amplitude');
title('ORIGINAL BIT SEQUENCE b(t)');
pr_sig = randi([0 1], 1, len);
pr_sig = 2*pr_sig - 1;
subplot(4,1,2);
stairs(pr_sig, 'LineWidth', 2);
axis([0 len -2 2]);
xlabel('Time'); ylabel('Amplitude');
title('PSEUDORANDOM BIT SEQUENCE pr\_sig(t)');
bbs = bb .* pr_sig;
subplot(4,1,3);
stairs(bbs, 'LineWidth', 2);
axis([0 len -2 2]);
xlabel('Time'); ylabel('Amplitude');
title('SPREAD SEQUENCE b(t) * pr\_sig(t)');
t = 0:1/10:2*pi;
c1 = sin(t + pi);
c2 = sin(t);
dsss = [];                     
for i = 1:length(bbs)
    if bbs(i) == -1
        dsss = [dsss c1];      
    else
        dsss = [dsss c2];      
    end
end
subplot(4,1,4);
plot(dsss, 'r', 'LineWidth', 1.5);
xlabel('Time'); ylabel('Amplitude');
title('DSSS MODULATED SIGNAL');
sgtitle('Direct Sequence Spread Spectrum (DSSS)');
