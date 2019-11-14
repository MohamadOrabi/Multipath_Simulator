function [O] = Corr(data,code)

O = ifft(fft(data).*conj(fft(code)));

end