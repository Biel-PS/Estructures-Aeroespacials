classdef DirectSolver < handle
    properties (Access = private)
        LHS
        RHS
    end

    methods (Access = public)

        function obj = DirectSolver (cParams)
            obj = obj.init (cParams);
        end

        function uL = compute (obj)
            uL = inv(obj.LHS)*obj.RHS;
            %uL = obj.LHS/obj.RHS;
        end

    end

    methods (Access = private)
        function obj = init (obj,cParams)
            %obj.u = inv(LHS)*RHS
            obj.RHS = cParams.RHS;
            obj.LHS = cParams.LHS;
        end
    end
end
