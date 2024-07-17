classdef IterativeSolver < handle

    properties
        uL
    end

    methods (Access = public)
        function obj = IterativeSolver (LHS,RHS)
            obj.solver(LHS,RHS);
        end
        function [uL] = return_value(obj)
            uL = obj.uL;
        end
    end
    methods (Access = private)
        function solver (obj, LHS, RHS)
            obj.uL = pcg(LHS,RHS);
        end
    end 
end