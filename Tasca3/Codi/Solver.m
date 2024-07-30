classdef Solver
    % properties(Access = private)
    %     cParams
    % end
    methods (Access = public ,Static)

        % function  obj = Solverclass (cParams)
        %     obj = obj.init(cParams);
        % end
        function obj = create (s)

            f = solverFactory ();
            obj = f.create(s);
        end
    end
end
