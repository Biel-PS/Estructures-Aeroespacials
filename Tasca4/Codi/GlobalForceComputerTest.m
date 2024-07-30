classdef GlobalForceComputerTest  < handle
    methods (Access = public,Static)
        function result = runTest (dataIn,fRef,tolerance)
            label = "Global Force Computer TEST:";
            obj = GlobalForceComputer (dataIn);
            fTest = obj.compute();
            %result = GlobalForceComputerTest.CompareTwoMagnitudes(fTest,fRef,tolerance);
            result = MagnitudeComparator.compare(fTest,fRef,tolerance,label);
        end
    end
end