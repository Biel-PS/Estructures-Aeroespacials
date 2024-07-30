classdef solverFactory

    methods (Access = public, Static)

       function obj = create(cParams)
           switch cParams.type
               case 'direct'
                   obj = DirectSolver (cParams);
               case 'iterative'
                   obj = IterativeSolver (cParams);
               case 'conjugate-gradient'
                   obj = ConjugateGradient(cParams);
           end
       end
    end

end
