classdef Solverclass
    properties(Access = private)
        cParams
    end
    methods (Access = public)

        function  obj = Solverclass (cParams)
            obj = obj.init(cParams);
        end

        function uL = compute_iterative (obj)
            a = IterativeSolver (obj.cParams);
            uL = a.compute();
        end
        
        function uL = compute_direct (obj)
            a = DirectSolver (obj.cParams);
            uL = a.compute();
        end

    end

    methods (Access = private)

        function obj = init (obj,cParams)
            obj.cParams = cParams;
        end

    end
end
