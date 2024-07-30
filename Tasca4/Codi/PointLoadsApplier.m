classdef PointLoadsApplier < handle

    methods (Access = public, Static)

        function fGlobal = apply (degFreedom,fGlobal,fExternal)
            for i = 1:size(fExternal,1)
                I = FromNod2Dof.compute(degFreedom,fExternal(i,1),fExternal(i,2));
                fGlobal(I) = fExternal(i,3);
            end
        end
        
    end
end