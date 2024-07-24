
classdef stiffnessTest < handle

    properties (Access = private)
        cParams_ref
        kRef
    end

    methods (Access = public)

        function obj = stiffnessTest ()
            obj = obj.init ();
        end

        function result = runTest (obj)
            tryMatrix = GlobalStiffnessMatrixComputer(obj.cParams_ref);
            result = false;

            if (obj.kRef == tryMatrix.compute())
                result = true;
                fprintf ("Global Stiffness Matrix Computer TEST: \nPASSED\n") %Optional message
                disp ("-------------------")
            else
                disp ("Global Stiffness Mmatrix Computer TEST:")
                fprintf (2,'FAILED\n')
                disp ("-------------------")
            end
        end
    end

    methods (Access = private)

        function obj = init (obj)
            load("stiffnesTestVariables.mat","cParams");
            obj.cParams_ref = cParams;
            obj.kRef = cParams.K_test;
        end
    end
end