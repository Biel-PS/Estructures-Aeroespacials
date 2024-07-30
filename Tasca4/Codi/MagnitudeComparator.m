classdef MagnitudeComparator < handle

    methods (Access = public, Static)

        function result = compare (a,b,tolerance,label)
            result = false;
            if (ismembertol(a , b, tolerance))
                result = true;
                fprintf(label);
                fprintf ('\nPASSED\n')
                disp ("-------------------")
            else
                disp(label)
                fprintf (2,'\nFAILED\n')
                disp ("-------------------")
            end

        end

    end

end