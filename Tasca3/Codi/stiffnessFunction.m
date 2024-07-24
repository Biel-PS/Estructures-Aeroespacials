function Kel = stiffnessFunction(data,x,Tn,m,Tm)
Kel = zeros(data.nne*data.ni,data.nne*data.ni,data.nel);

    for e = 1:data.nel
        xel = x(Tn(e,:),:);
        Le = sqrt((xel(2,1)-xel(1,1))^2 + (xel(2,2)-xel(1,2))^2);
        c = (xel(2,1)-xel(1,1))/Le;
        s = (xel(2,2)-xel(1,2))/Le;
        cs = c*s;
        c2 = c^2;
        s2 = s^2;

        E = m(Tm(e),1);
        A = m(Tm(e),2);
        
        K = E*A/Le * [c2 cs -c2 -cs; 
            cs s2 -cs -s2; 
            -c2 -cs c2 cs; 
            -cs -s2 cs s2]; % element stiffness matrix
        
        Kel(:,:,e) = K; % stiffness matrices
        
    end
end