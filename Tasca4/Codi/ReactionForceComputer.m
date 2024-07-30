classdef ReactionForceComputer < handle

    properties (Access = private)
        k
        u
        f
    end

    methods (Access = public)

        function obj =  ReactionForceComputer (cParams)
            obj = obj.init(cParams);

        end 

        function f = compute (obj)

            f = obj.k * obj.u - obj.f;
            f(f<1e-10 & f > -1e-10) = 0; %OPTIONAL, JUST FOR GOOD LOOKING
        end

    end

    methods (Access = private)

        function obj = init (obj,cParams)
            
            obj.k = cParams.K;
            obj.u = cParams.u;
            obj.f = cParams.f;

        end

    end

end