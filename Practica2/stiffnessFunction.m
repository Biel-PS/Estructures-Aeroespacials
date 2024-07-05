function Kel = stiffnessFunction(data,x,Tn,m,Tm)
Kel = zeros(data.nne*data.ni,data.nne*data.ni,data.nel);

    for e = 1:data.nel
        
        x_el = x(Tn(e,:),:);

        d_x = x_el(2,1) - x_el(1,1);
        d_y = x_el(2,2) - x_el(1,2);
        d_z = x_el(2,3) - x_el(1,3);

        Le = sqrt(d_x^2 + d_y^2 + d_z^2);
       

        E = m(Tm(e),1);
        A = m(Tm(e),2);

        R = 1/Le*[d_x d_y d_z 0 0 0; 0 0 0 d_x d_y d_z];

        K = E*A/Le * [1 -1;-1 1]; % element stiffness matrix
        
        Kel(:,:,e) = transpose(R) * K * R; % stiffness matrices
        
    end
end