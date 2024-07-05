
function fel = forceFunction(data,x,Tn,m,Tm,a,g)
fel = zeros(data.nne*data.ni,data.nel);

    for e = 1:data.nel

        x_el = x(Tn(e,:),:);

        d_x = x_el(2,1) - x_el(1,1);
        d_y = x_el(2,2) - x_el(1,2);
        d_z = x_el(2,3) - x_el(1,3);

        Le = sqrt(d_x^2 + d_y^2 + d_z^2);
        
        rho = m(Tm(e),4);
        A = m(Tm(e),2);
        gravity = [0;0;g];
        fel(:,e) = rho*A*Le/2*[gravity-a(:,Tn(e,1));gravity-a(:,Tn(e,2))]; % force vectors

    end

end