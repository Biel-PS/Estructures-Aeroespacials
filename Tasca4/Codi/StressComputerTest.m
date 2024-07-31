classdef StressComputerTest < handle
    methods (Access = public,Static)
        function result = runTest (dataIn,stressRef,tolerance)
            label = "Stress Computer Test";
            obj = StressComputer (dataIn);
            stressTest = obj.compute();
            result = MagnitudeComparator.compare(stressRef,stressTest,tolerance,label);
        end
    end
end
