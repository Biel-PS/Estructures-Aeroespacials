function X = Deffine_Geometry (radius,number_nodes,x0,y0)
    X = zeros(number_nodes,2);
    angles = 0:(360/(number_nodes-1)):359;
    X(1:number_nodes-1,1) =  radius*cosd(angles+22.5) + x0;
    X(1:number_nodes-1,2) =  radius*sind(angles+22.5) + y0;
    X(number_nodes,1) =  x0;
    X(number_nodes,2) =  y0;
end
