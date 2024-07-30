classdef DisplacementSolverTest < handle
    methods (Access = public,Static)
        function result = runIterativeTest (dataIn,uRef,tolerance)
            label = "Iterative Displacement Computer TEST:";
            dataIn.type = 'iterative';
            solver = Solver.create(dataIn);
            uTest = solver.compute();
            result = MagnitudeComparator.compare(uTest,uRef,tolerance,label);
        end

        function result = runDirectTest (dataIn,uRef,tolerance)
            label = "Direct Displacement Computer TEST:";
            dataIn.type = 'direct';
            solver = Solver.create(dataIn);
            uTest = solver.compute();
            result = MagnitudeComparator.compare(uTest,uRef,tolerance,label);
        end
    end
end