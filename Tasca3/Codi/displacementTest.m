classdef displacementTest < handle

    properties (Access = private)
        data
        k
        f
        up
        vp
        cParams_test
    end

    methods (Access = public)

        function obj = displacementTest ()

            obj = obj.init();

        end

        function result = runIterativeTest (obj)
            [uRef,~] = solveSystem(obj.data,obj.k,obj.f,obj.up,obj.vp);
            
            displacement = Solverclass(obj.cParams_test);
            uTest = displacement.compute_iterative;
            tolerance = 1e-10;
            result = false;

            if (ismembertol(uRef , uTest, tolerance)) %Being iterative, we set a tolerance
                result = true;
                fprintf ("Iterative Displacement Computer TEST: \nPASSED\n");
                disp ("-------------------")
            else
                disp ("Iterative Displacement Computer TEST:");
                fprintf (2,'FAILED\n')
                disp ("-------------------")
            end
        
        end


        function result = runDirectTest (obj)
            [uRef,~] = solveSystem(obj.data,obj.k,obj.f,obj.up,obj.vp);
            
            displacement = Solverclass(obj.cParams_test);
            uTest = displacement.compute_direct;

            result = false;

            if (uRef == uTest)
                result = true;
                fprintf("Direct Displacement Computer TEST: \nPASSED\n")
                disp ("-------------------")
            else
                disp("Direct Displacement Computer TEST: FAILED")
                fprintf (2,'FAILED\n')
                disp ("-------------------")
            end
        
        end


    end

    methods (Access = private)

        function obj = init (obj)
            load ("ReactionForceTest_variables.mat","cParams");
            obj.data = cParams.data;
            obj.k = cParams.K;
            obj.f = cParams.f;
            obj.up = cParams.up;
            obj.vp = cParams.vp;
            obj.cParams_test = cParams;

        end
    end



end