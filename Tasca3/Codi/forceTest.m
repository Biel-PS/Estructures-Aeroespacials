classdef forceTest < handle

    properties (Access = private)
        data
        k
        f
        up
        vp
        cParams_test
    end

    methods (Access = public)

        function obj = forceTest ()
            obj = obj.init();
        end
        
        function result = runTest (obj)

            [~,rRef] = solveSystem(obj.data,obj.k,obj.f,obj.up,obj.vp);

            solveForce = ReactionForceComputer(obj.cParams_test);
            rTest = solveForce.compute;
            result = false;

            if (rTest(obj.vp) == rRef)
                result = true;
                fprintf ("Force Computer TEST: \nPASSED\n") %Optional message
                disp ("-------------------")
            else
                disp ("Force Computer TEST:")
                fprintf (2,'FAILED\n')
                disp ("-------------------")
            end
        end
    end

    methods (Access = private)

        function obj = init (obj)
            load("ReactionForceTest_variables.mat","cParams")
            obj.data = cParams.data;
            obj.k = cParams.K;
            obj.f = cParams.f;
            obj.up = cParams.up;
            obj.vp = cParams.vp;
            obj.cParams_test = cParams;
        end
    end
end
