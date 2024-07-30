function [crit] = Critical_tension (m,Tm,data,x,Tn)
    crit = zeros (data.nel,1);
    for i=1:data.nel
        xel = x(Tn(i,:),:);
        Le = sqrt((xel(2,1)-xel(1,1))^2 + (xel(2,2)-xel(1,2))^2);
        %Tensio critica definida en MPa
        crit(i,1) = -(pi^2*m(Tm(i),1)*m(Tm(i),4)/(Le^2*m(Tm(i),2)))/10^6; 
    end
end