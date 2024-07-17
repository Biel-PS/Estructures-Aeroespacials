classdef DirectSolver < handle
    properties (Access = private)
        uL
    end

    methods (Access = public)
        function [obj] = DirectSolver (LHS,RHS)
            obj.solver (LHS,RHS);
        end
        function [uL] = return_value (obj)
            uL = obj.uL;
        end

    end

    methods (Access = private)
        function solver (obj,LHS,RHS)
            %obj.u = inv(LHS)*RHS
            obj.uL = LHS/RHS;
        end
    end
end
