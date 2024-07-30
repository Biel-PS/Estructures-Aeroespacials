classdef stiffnessTest < handle

    methods (Access = public, Static)

        function result = runTest (initialData,KRef)

            tryMatrix = GlobalStiffnessMatrixComputer(initialData);
            result = false;

            if (KRef == tryMatrix.compute())
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
end