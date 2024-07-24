classdef IterativeSolver < handle

    properties
        LHS
        RHS
        vf
    end

    methods (Access = public)
        function obj = IterativeSolver (cParams)
            obj = obj.init(cParams);
        end
        function [uL] = compute(obj)
            uL = zeros (size(obj.LHS,1),1);
            
            [uL(obj.vf),flag] = pcg(obj.LHS,obj.RHS);

            
        end
    end
    methods (Access = private)

        function obj = init (obj,cParams)
            obj.LHS = cParams.LHS;
            obj.RHS = cParams.RHS;
            obj.vf = cParams.vf;
        end
    end 
end