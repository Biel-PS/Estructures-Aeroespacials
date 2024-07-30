classdef   FromNod2Dof < handle
    methods (Access = public, Static)
        function I = compute(ni,i,j)
            I = ni*i-(ni-j);
        end
    end
end