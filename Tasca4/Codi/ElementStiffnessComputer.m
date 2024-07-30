classdef ElementStiffnessComputer < handle
    methods (Access = public,Static)

        function Kel = compute (dataIn)

            obj = ElementStiffnessComputer;
            matrixDim = dataIn.data.nne*dataIn.data.ni;
            Kel = zeros(matrixDim,matrixDim,dataIn.data.nel);
          
            for e = 1:dataIn.data.nel

                S = obj.computeElementGeometry (e,dataIn);
                R = obj.computeRotationMatrix (S);
                K = obj.computeIndividualElementStiffnessMatrix(dataIn,S,R,e);
                Kel(:,:,e) = K; % stiffness matrices

            end

        end

    end

    methods (Access = private,Static)
        function R = computeRotationMatrix (S)

            cos = S.deltaX/S.longElem;
            sin = S.deltaY/S.longElem;

            cs = cos*sin;
            c2 = cos^2;
            s2 = sin^2;

            R = [c2 cs -c2 -cs;
                cs s2 -cs -s2;
                -c2 -cs c2 cs;
                -cs -s2 cs s2];
        end
        function S = computeElementGeometry (elementIndex,dataIn)

            coordElem = dataIn.x(dataIn.Tn(elementIndex,:),:);
            deltaX = coordElem(2,1)-coordElem(1,1);
            deltaY = coordElem(2,2)-coordElem(1,2);
            longElem = sqrt(deltaX^2 + deltaY^2);

            S.deltaX = deltaX;
            S.deltaY = deltaY;
            S.longElem  = longElem;

        end
        function K = computeIndividualElementStiffnessMatrix (dataIn,S,R,elementIndex)

                E = dataIn.m(dataIn.Tm(elementIndex),1);
                A = dataIn.m(dataIn.Tm(elementIndex),2);

                K = E*A/S.longElem * R; % element stiffness matrix

              
        

        end
    end 
end