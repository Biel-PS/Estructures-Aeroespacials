classdef DirectSolver < handle
    properties (Access = private)
        LHS
        RHS
        vf
    end

    methods (Access = public)

        function obj = DirectSolver (cParams)
            obj = obj.init (cParams);
        end

        function uL = compute (obj)
            uL = zeros (size(obj.LHS,1),1);
            uL(obj.vf) = inv(obj.LHS)*obj.RHS;
        end

    end

    methods (Access = private)
        function obj = init (obj,cParams)
            obj.RHS = cParams.RHS;
            obj.LHS = cParams.LHS;
            obj.vf = cParams.vf;
        end
    end
end