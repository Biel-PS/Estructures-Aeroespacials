classdef ElementForceComputerTest < handle

    methods (Access = public, Static)

        function result = runTest (dataIn,fElmRef,tolerance)
            label = "Element Force Computer TEST:";
            fElmTest = ElementForceComputer.compute (dataIn);
            result = MagnitudeComparator.compare(fElmTest,fElmRef,tolerance,label);
        end
    
    end
end