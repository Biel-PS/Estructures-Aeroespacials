classdef BoundaryConditionsApplyerTest < handle
    methods (Access = public,Static)
        function [resultVp, resultUp] = runTest (restrictedDofMatrix,nDofElement,upRef,vpRef,tolerance)
            label = "Boundary Conditions Applier [up] TEST:";
            [upTest,vpTest] = BoundaryConditionsApplyer.apply (restrictedDofMatrix,nDofElement);
            resultUp = MagnitudeComparator.compare(upTest,upRef,tolerance,label);
            label = "Boundary Conditions Applier [vp] TEST:";
            resultVp = MagnitudeComparator.compare(vpTest,vpRef,tolerance,label);
        end
    end
end
