classdef Solverclass
    properties(Access = private)
        uL
    end
    methods (Access = public)
        function  obj = Solverclass (option,LHS,RHS)
            switch option
                case 0
                    a = DirectSolver (LHS,RHS);
                    obj.uL = a.return_value;
                otherwise
                    b = IterativeSolver (LHS,RHS);
                    obj.uL = b.return_value;
            end

        end
        
        function [uL] = return_value (obj)
            uL = obj.uL;
        end
    end

end
