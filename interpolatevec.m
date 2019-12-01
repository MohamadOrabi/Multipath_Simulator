function o = interpolatevec(v)
    t_interp = 1:length(v);
    t_interp1 = 1:1e-3:length(v);
    o = interp1(t_interp,v,t_interp1);

    %figure; plot(t_interp,v)
    %hold on
    %plot(t_interp1,v_interp)
end
