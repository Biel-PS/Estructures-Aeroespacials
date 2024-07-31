classdef StressComputer < handle

    properties (Access = private)
        nElm %nel
        nNodElm %nne
        Dofs4node %ni
        dofConnecMtrx %Td
        nodalConnecMtrx %Tn
        materialProperties %m
        materialConnecMtrx %Tm
        uMatrx %u
        nodCoord %x


    end

    methods (Access = public)
        function obj = StressComputer (cParams)
            obj = obj.init(cParams);

        end
        function sig = compute (obj)

            sig = zeros (obj.nElm,1);


            for e = 1:obj.nElm
                
                S = obj.geometryAndRotationCompute(e);
                S.uElm = obj.uElmCompute(e);    
                localSig = obj.localSigCompute (e,S);
                sig (e) = localSig;
                
            end

        end

    end

    methods (Access = private)
        function obj = init (obj,cParams)

            obj.nElm = cParams.data.nel;
            obj.uMatrx = cParams.u;
            obj.nNodElm = cParams.data.nne;
            obj.nodCoord = cParams.x;
            obj.Dofs4node = cParams.data.ni;
            obj.dofConnecMtrx = cParams.Td;
            obj.nodalConnecMtrx = cParams.Tn;
            obj.materialProperties = cParams.m;
            obj.materialConnecMtrx = cParams.Tm;

        end

        function uElm = uElmCompute (obj,e)
            totalDofElm = obj.nNodElm*obj.Dofs4node;
            uElm = zeros(totalDofElm,1);
            uElmSpan = obj.dofConnecMtrx(e,1:totalDofElm);
            uElm(1:totalDofElm) = obj.uMatrx(uElmSpan);
        end
        function S = geometryAndRotationCompute (obj,e)

            xel = obj.nodCoord(obj.nodalConnecMtrx(e,:),:);
            deltaX = xel(2,1)-xel(1,1);
            deltaY = xel(2,2)-xel(1,2);
            Le = sqrt(deltaX^2 + deltaY^2);

            c = deltaX/Le;
            s = deltaY/Le;

            R = [c s 0 0;
                -s c 0 0;
                0 0 c s;
                0 0 -s c];

            S.R = R;
            S.Le = Le;

        end

        function localSig = localSigCompute (obj,e,S)
            sigma0 = obj.materialProperties(obj.materialConnecMtrx(e),3);
            E = obj.materialProperties(obj.materialConnecMtrx(e),1);

            epsi = (1/S.Le)*[-1 0 1 0]*S.R*S.uElm; % element strain
            localSig = E*epsi + sigma0;
        end

    end

end