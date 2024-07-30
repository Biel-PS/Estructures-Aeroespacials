classdef GlobalForceComputer < handle

    properties (Access = private)
        connectMatrix
        nDof
        fElm
        numElm
        numNodElm
        degFreedom
        fExternal
    end

    methods (Access = public)
        function obj = GlobalForceComputer (cParams)
            obj = obj.init (cParams);
        end
        function fGlobal = compute (obj)
             totalDofElement = obj.numNodElm * obj.degFreedom;
             fGlobal = zeros(obj.nDof,1);
                
            for e = 1:obj.numElm
                dofNodeA = [obj.connectMatrix(e,1:obj.degFreedom)];
                dofNodeB = [obj.connectMatrix(e,(obj.degFreedom+1):totalDofElement)];
                DOF = [dofNodeA,dofNodeB];
                fGlobal(DOF) = fGlobal(DOF) + obj.fElm(1:totalDofElement,e);
            end

            fGlobal = PointLoadsApplier.apply (obj.degFreedom,fGlobal,obj.fExternal);

        end
    end

    methods (Access = private)
        function obj = init (obj,cParams)
            obj.connectMatrix = cParams.Td;
            obj.nDof = cParams.data.ndof;
            obj.degFreedom = cParams.data.ni;
            obj.numNodElm = cParams.data.nne;
            obj.numElm = cParams.data.nel;
            obj.fElm = cParams.fElm;
            obj.fExternal = cParams.fExternal;
        end
    end
end
