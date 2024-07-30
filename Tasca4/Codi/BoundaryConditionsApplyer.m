classdef BoundaryConditionsApplyer < handle

    methods (Access = public,Static)

        function [up,vp] = apply (restrictedDofMatrix,nDofElement)
            nRestrictedDof = size(restrictedDofMatrix,1);
            vp = zeros(nRestrictedDof,1);
            up = zeros(nRestrictedDof,1);
            for i = 1:nRestrictedDof
                vp(i) = FromNod2Dof.compute(nDofElement,restrictedDofMatrix(i,1),restrictedDofMatrix(i,2)); % DOF index
                up(i) = restrictedDofMatrix(i,3);                         % DOF value
            end
        end
    end
end