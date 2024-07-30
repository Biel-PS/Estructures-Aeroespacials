
classdef GlobalStiffnessComputerTest < handle
    methods (Access = public, Static)
        function result = runTest (dataIn,kGlobalRef,tolerance)

            label = "Global Stiffness Matrix Computer TEST:";
            tryMatrix = GlobalStiffnessMatrixComputer(dataIn);
            kTest = tryMatrix.compute();
            result = MagnitudeComparator.compare(kTest,kGlobalRef,tolerance,label);
        
        end
    end
end