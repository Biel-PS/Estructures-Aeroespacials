function sf_trac = SFtrac(m,Tm,sig)
% Safety factor for traction

sig_ref = 0;

    for e = 1:size(sig,1)
        for jj = 1:size(sig,2)
            if sig(e,jj)>sig_ref
                sf_trac = m(Tm(e),5)/sig(e,jj);
                sig_ref = sig(e,jj);
            end
        end
    end

end