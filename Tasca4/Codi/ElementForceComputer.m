classdef ElementForceComputer < handle

    methods (Access = public, Static)
        function fElm = compute (dataIn)
            fElm = zeros(dataIn.data.nne*dataIn.data.ni,dataIn.data.nel);
            obj = ElementForceComputer;
            for e = 1:dataIn.data.nel
                S = obj.geometryCompute (dataIn,e);
                R = obj.rotationMatrixCompute (S);
                fElm (:,e) = fElm (:,e) + obj.localElementForceCompute (dataIn,R,e);
            end

        end
    end

    methods (Access = private, Static)

        function S = geometryCompute (dataIn,e)

            S.xel = dataIn.x(dataIn.Tn(e,:),:);
            deltaX = S.xel(2,1)-S.xel(1,1);
            deltaY = S.xel(2,2)-S.xel(1,2);
            S.Le = sqrt(deltaX^2 + deltaY^2);
            S.c = deltaX/S.Le;
            S.s = deltaY/S.Le;
        end
        function R = rotationMatrixCompute (S)
            c = S.c;
            s = S.s;

            R = [c s 0 0;
                -s c 0 0;
                0 0 c s;
                0 0 -s c];
        end
        function Fel = localElementForceCompute (dataIn,R,e)
        
        sigma0 = dataIn.m(dataIn.Tm(e),3);
        A = dataIn.m(dataIn.Tm(e),2);
        
        Fel = -sigma0*A*R'*[-1; 0; 1; 0];

        end
    end
end