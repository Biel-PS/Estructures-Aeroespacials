function [f_x,f_z] = Force_sorter (F,data)
    
    f_x = 0;
    f_z = 0;
    
    for i = 1:data.nnod
        index = find (F(:,1) == i & F(:,2) == 1);
        if isempty(index) == false
            f_x = F(index,3) +f_x;       
        end
        
        index = find (F(:,1) == i & F(:,2) == 3);
    
        if isempty(index) == false
            f_z = F(index,3) + f_z;       
        end
    end

end
