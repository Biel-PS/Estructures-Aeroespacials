classdef ElementStiffnessComputerTest < handle

    methods (Access = public, Static)

        function result = runTest (dataIn,kRef,tolerance)

            label = "Local Stiffness Matrix Computer TEST:";
            kTest = ElementStiffnessComputer.compute (dataIn);
            result = MagnitudeComparator.compare(kTest,kRef,tolerance,label);

        end
    end
end
