clc; clear; close all;
disp('Cyclic Code (7,4)');
m = input('Enter 4 message bits [e.g. [1 0 1 1]]: ');
g = [1 0 1 1];   % Generator polynomial: x^3 + x + 1
r = length(g) - 1;
dividend = [m zeros(1, r)];
for i = 1:length(m)
    if dividend(i) == 1
        dividend(i:i+r) = xor(dividend(i:i+r), g);
    end
end
rem = dividend(end-r+1:end);
c = [m rem];
disp(['Message bits : ' num2str(m)]);
disp(['Codeword     : ' num2str(c)]);
