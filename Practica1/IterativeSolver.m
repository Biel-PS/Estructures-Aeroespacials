classdef IterativeSolver < handle

    properties
        LHS
        RHS
    end

    methods (Access = public)
        function obj = IterativeSolver (cParams)
            obj = obj.init(cParams);
        end
        function [uL] = compute(obj)
            uL = pcg(obj.LHS,obj.RHS);
        end
    end
    methods (Access = private)

        function obj = init (obj,cParams)
            obj.LHS = cParams.LHS;
            obj.RHS = cParams.RHS;
        end
    end 
end