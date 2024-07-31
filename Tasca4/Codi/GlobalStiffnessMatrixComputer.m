
classdef GlobalStiffnessMatrixComputer < handle

    properties (Access = private)
        Tnodal
        nDOFnode
        nNode
        dataIn
    end
    methods (Access = public)
        function obj = GlobalStiffnessMatrixComputer(cParams)
            obj = obj.init(cParams);

        end
        function K = compute(obj)

            kElm = ElementStiffnessComputer.compute(obj.dataIn);

            nDOFtotal = obj.nDOFnode*obj.nNode;
            nDOFtotalElem = size(obj.Tnodal,2);
            K = zeros (nDOFtotal,nDOFtotal);
            nElem = size(obj.Tnodal,1);
            
            for e = 1:nElem %implementar vectorització
                gDOFnodeA = obj.Tnodal(e,1:obj.nDOFnode);
                gDOFnodeB = obj.Tnodal(e,obj.nDOFnode+1:nDOFtotalElem);
                DOF = [gDOFnodeA,gDOFnodeB];
                K(DOF,DOF) = K(DOF,DOF)+kElm(:,:,e);
            end
        end
    end
    methods (Access = private)
        function obj = init (obj,cParams)
            obj.Tnodal = cParams.Tnodal;
            obj.nDOFnode = cParams.nDOFnode;
            obj.nNode = cParams.nNode;
            obj.dataIn = cParams;
        end
    end
end