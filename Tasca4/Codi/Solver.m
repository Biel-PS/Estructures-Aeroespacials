classdef Solver
    methods (Access = public ,Static)
        function obj = create (s)
            f = solverFactory ();
            obj = f.create(s);
        end
    end
end
