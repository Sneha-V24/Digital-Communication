clc; clear; close all;
disp('Linear Block Code (7,4)');
m = input('Enter 4 message bits [e.g. [1 0 1 1]]: ');
if length(m) ~= 4
    error('Enter exactly 4 bits!');
end
G = [1 0 0 0 1 0 1;
     0 1 0 0 1 1 1;
     0 0 1 0 1 1 0;
     0 0 0 1 0 1 1];
c = mod(m * G, 2);
disp(['Message bits : ' num2str(m)]);
disp(['Codeword     : ' num2str(c)]);

