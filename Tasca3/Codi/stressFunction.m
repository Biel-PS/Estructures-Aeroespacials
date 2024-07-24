function sig = stressFunction(data,x,Tn,m,Tm,Td,u)
    sig = zeros (data.nel,1);
    
    for e = 1:data.nel
        uel = zeros(data.nne * data.ni,1);
        for i = 1:(data.nne*data.ni)
            uel(i) = u(Td(e,i));
        end
        xel = x(Tn(e,:),:);
        Le = sqrt((xel(2,1)-xel(1,1))^2 + (xel(2,2)-xel(1,2))^2);
        c = (xel(2,1)-xel(1,1))/Le;
        s = (xel(2,2)-xel(1,2))/Le;
        
        R = [c s 0 0; 
            -s c 0 0; 
            0 0 c s; 
            0 0 -s c];

        sigma0 = m(Tm(e),3);
        E = m(Tm(e),1); 

        epsi = (1/Le)*[-1 0 1 0]*R*uel; % element strain
        sig(e) = E*epsi + sigma0; % element stress
    end
   
end