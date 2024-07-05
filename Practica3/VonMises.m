function [sigVM,posmax] = VonMises(open,h1,h2,d,nnodes,data,m,Sel,Mbel,Mtel)

[x_c, Tn, Tm] = node_pos(h1,h2,d,nnodes,open);

data.nnod = size(x_c,1); % Number of nodes 
data.nd = size(x_c,2);   % Problem dimension
data.ndof = data.nnod*data.ni;  % Total number of degrees of freedom
data.nel = size(Tn,1); % Number of elements 
data.nne = size(Tn,2); % Number of nodes in a bar

[Xo,Yo,Xs,Ys,Atot,Ixx,Iyy,Ixy,J,Ain] = SectionProperties(data,x_c,Tn,m,Tm,open);

sigVM = zeros(1,size(Sel,2));
posmax = zeros(2,size(Sel,2));
for bnod = 1:size(Sel,2)
    Mx_p = -Mbel(1,bnod);
    My_p = 0;
    [sigma_c,~] = normalStress(data,x_c,Tn,Xo,Yo,Ixx,Iyy,Ixy,Mx_p,My_p);
    
    Sx_p = 0; Sy_p = Sel(1,bnod);
    [tau_s_c,~] = TangentialShear(data,x_c,Tn,m,Tm,Xo,Yo,Xs,Ys,Ain,Ixx,Iyy,Ixy,Sx_p,Sy_p,open);
    
    Mz_p = Mtel(1,bnod);
    [tau_t_c,~] = TangentialTorsion(data,x_c,Tn,m,Tm,Mz_p,J,Ain,open);
    
    
        for e = 1:data.nel
            control = sqrt(sigma_c(1,e)^2+3*(tau_s_c(1,e)+tau_t_c(1,e))^2);
            if control > sigVM
                sigVM(bnod) = control;
                posmax(:,bnod) = [x_c(e,1); x_c(e,2)];
            end
        end
end

end
