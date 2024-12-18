
classdef GlobalStiffnessMatrixComputer < handle

    properties (Access = private)
        Tnodal
        nDOFnode
        kElm
        nNode
    end

    methods (Access = public)

        function obj = GlobalStiffnessMatrixComputer(cParams)
            obj = obj.init(cParams);

        end

        function K = compute(obj)
            nDOFtotal = obj.nDOFnode*obj.nNode;
            nDOFtotalElem = size(obj.Tnodal,2);
            K = zeros (nDOFtotal,nDOFtotal);
            nElem = size(obj.Tnodal,1);

            for e = 1:nElem
                globalDOFnodeA = obj.Tnodal(e,1:obj.nDOFnode);
                globalDOFnodeB = obj.Tnodal(e,obj.nDOFnode+1:nDOFtotalElem);
                DOF = [globalDOFnodeA,globalDOFnodeB];
                K(DOF,DOF) = K(DOF,DOF)+obj.kElm(:,:,e);
            end


        end

    end

    methods (Access = private)

        function obj = init (obj,cParams)
            obj.Tnodal = cParams.Tnodal;
            obj.nDOFnode = cParams.nDOFnode;
            obj.kElm = cParams.kElm;
            obj.nNode = cParams.nNode;
        end
    end
end