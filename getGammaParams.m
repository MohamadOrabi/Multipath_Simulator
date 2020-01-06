function [gamma,varsigma] = getGammaParams(El)

if 0<=El && El<15
    gamma = 2.62;
    varsigma = 129.83;
elseif 15<=El && El<30
    gamma = 2.77;
    varsigma = 105.52;
elseif 30<=El && El<45
    gamma = 2.81;
    varsigma = 80.93;
elseif 45<=El && El<60
    gamma = 2.56;
    varsigma = 65.12;
elseif 60<=El && El<75
    gamma = 2.47;
    varsigma = 53.22;
elseif 75<=El && El<90
    gamma = 2.40;
    varsigma = 43.24;
else
    gamma = 2.40;
    varsigma = 43.24;
    warning('El out of bounds')
end

end
