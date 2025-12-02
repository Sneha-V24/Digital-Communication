clc; clear; close all;
inputBits = input('Enter input bits as row vector (e.g. [1 0 1 1 0 0 1]): ');
K = 3; 
g1 = [1 1 1];  
g2 = [1 0 1]; 
%data = inputBits %Without traling zeros
data = [inputBits zeros(1, K-1)];
mem = zeros(1, K-1);
encoded = zeros(1, length(data)*2);
out_idx = 1;
for i = 1:length(data)
 u = data(i); 
 taps = [u mem]; 
 out1 = mod(sum(g1 .* taps), 2);
 out2 = mod(sum(g2 .* taps), 2);
 encoded(out_idx) = out1;
 encoded(out_idx+1) = out2;
 out_idx = out_idx + 2;
 if K > 1
 mem = [u mem(1:end-1)];
 end
end
fprintf('\nInput Bits:\n');
disp(inputBits);
fprintf('Input bits after appending %d tail zeros:\n', K-1);
disp(data);
fprintf('Encoded Bits (rate 1/2):\n');
disp(encoded);

