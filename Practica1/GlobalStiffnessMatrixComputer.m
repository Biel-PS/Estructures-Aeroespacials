classdef GlobalStiffnessMatrixComputer < handle

    properties (Access = private)
        k_global
        F_global
    end

    methods (Access = public)
        
        function obj = GlobalStiffnessMatrixComputer(Kel,Tnodal,nnod, ndof,fel)
           obj.Calc_matrix (Kel,Tnodal,nnod, ndof,fel);
        end
        function [K_g,F_g] = return_matrix (obj)
            K_g = obj.k_global;
            F_g = obj.F_global;
        end
    end

    methods (Access = private)
        function obj = Calc_matrix(obj,Kel,Tnodal,nnod, ndof,fel)
            F_g = zeros(ndof*nnod,1);
            K_g = zeros(ndof*nnod,ndof*nnod);
            for e = 1:(size (Tnodal,1)) 
                for i = 1:(2*ndof)
                    F_g(Tnodal(e,i)) = F_g(Tnodal(e,i)) + fel(i,e);
                    for j = 1:(2*ndof)
                        K_g(Tnodal(e,i),Tnodal(e,j)) = K_g(Tnodal(e,i),Tnodal(e,j)) + Kel(i,j,e);
                    end
                end
            end
            obj.F_global = F_g;
            obj.k_global = K_g;
        end
    end
end