function [A B C D] = PLL_getss(B,fs)
%Takes in the bandwidth of the phase and gives the state space
%representation of a 2nd order PLL filter.

K = 8/3*B;
a = K/2;
num = [K a*K];
den = [1 0];
sys = tf(num,den);

sys = c2d(sys,5000/fs);
[A B C D] = ssdata(sys);
end