function sf_buck = SFbuck(data,x,Tn,m,Tm,sig)
% Safety factor for buckling

sig = -sig;
sig_ref = 0;

    for e = 1:data.nel

        x_el = x(Tn(e,:),:);
        d_x = x_el(2,1) - x_el(1,1);
        d_y = x_el(2,2) - x_el(1,2);
        d_z = x_el(2,3) - x_el(1,3);

        Le = sqrt(d_x^2 + d_y^2 + d_z^2);

        E = m(Tm(e),1);
        A = m(Tm(e),2);
        I = m(Tm(e),6);

        sig_crit = (pi^2*E*I)/(Le^2*A);

        for jj = 1:size(sig,2)
            if Tm(e)~=1 && sig(e,jj)>sig_ref
                sf_buck = sig_crit/abs(sig(e,jj));
                sig_ref = sig(e,jj);
            end
         end

    end

end