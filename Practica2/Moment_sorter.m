function [Total_moment] = Moment_sorter (F,data,dist_to_cdg)
    
    Total_moment = zeros(1,3);
    
    for i = 1:data.nnod
        index_x = find (F(:,1) == i & F(:,2) == 1);
        index_z = find (F(:,1) == i & F(:,2) == 3);

        Vect_prod = [0,dist_to_cdg(i,3) * F(index_x,3) - F(index_z,3) * dist_to_cdg(i,1),0];

        Total_moment = Total_moment + Vect_prod;

        
    end

end
