
function fel = forceFunction(data,x,Tn,m,Tm)
fel = zeros(data.nne*data.ni,data.nel);

    for e = 1:data.nel
        xel = x(Tn(e,:),:);
        Le = sqrt((xel(2,1)-xel(1,1))^2 + (xel(2,2)-xel(1,2))^2);
        c = (xel(2,1)-xel(1,1))/Le;
        s = (xel(2,2)-xel(1,2))/Le;
        
        R = [c s 0 0; 
            -s c 0 0; 
            0 0 c s; 
            0 0 -s c];

        sigma0 = m(Tm(e),3);
        A = m(Tm(e),2);
        
        fel(:,e) = -sigma0*A*R'*[-1; 0; 1; 0]; % force vectors

    end

end