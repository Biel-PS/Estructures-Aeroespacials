%% *1. Research what the object-oriented programming is, and compare it with other programming paradigms. Explain the fundamentals of OOP.*
% 
% 
% OOP is a type of way of programming that focuses on data structures called 
% objects.  An object is, as mentioned, a data structure, and it can be understood 
% as an instance of a class, which contains attributes and methods. The hierarchy 
% of OOP can be described as follows. _(https://www.techtarget.com/searchapparchitecture/definition/object-oriented-programming-OOP)_
% 
% First, a class is created. This class contains within itself a variety of 
% attributes, which are parameters intrinsic to the class (it is usually a set 
% of variables) and are what distinguish objects from the same class.  The class 
% can also contain a set of methods, which are functions that all instances of 
% a class can perform. Finally, an object is an instance of a class that has its 
% own differentiable characteristics and data stored in the attributes field. 
% To summarize, we can say that OOP is a style of programming that focuses on 
% the design and use of objects rather than the logic required to manipulate them.
% 
% The three of the main paradigms nowadays are OOP, functional programming and 
% procedural programming. Functional programming is a subtype of the declarative 
% programming paradigm, and it makes use of immutable functions to operate. Procedural 
% programming is a paradigm that priorities the use of logical steps in a procedural 
% manner to complete a task.
% 
% In the functional paradigm, the main focus is on the composition of function, 
% while in the OOP the main focus is the composition and communication of objects 
% composed of methods and attributes. In the Procedural Programming, the focus 
% on procedures (operations) is the main goal.
% 
% Functional paradigm is useful for concurrent and parallel programming whilst 
% OOP is really useful for scalable software systems and cooperative programming 
% as the objects are self-contained. Procedural programming is suitable for general-purpose 
% programming.
% 
% Finally, the way that the different paradigms aim to organize the code are: 
% for the OOP in objects, for the Functional in  Modules and functions and, in 
% the Procedural, in modules and procedures. 
% 
% The fundamentals of OOP are:
% 
% *Encapsulation:*
% 
% All the important information is contained inside an object, and only selected 
% information is exposed. Every object's data is privately held inside its domain, 
% and other objects cannot access it nor change it. 
% 
% 
% 
% *Abstraction:*
% 
% Objects only reveal internal mechanism that are useful to other objects, hiding 
% any unnecessary implementation code.
% 
% 
% 
% *Inheritance*:
% 
% Classes can reuse code from other classes, which means that it is possible 
% to establish relationships and subclasses between objects.
% 
% 
% 
% *Polymorphism:*
% 
% Objects share the behavior of their parent class and can take on more than 
% one form. It helps reduce the need to duplicate code, as different objects can 
% have different behaviors even thought they share the same parent class via polymorphism.
% 
% 
% 
% *Coupling:*
% 
% Relation between classes, if two classes have two elements connected, the 
% change of one of them will change it in the other.
% 
% 
% 
% *Association:*
% 
% Connection between classes, classes can be connected to share data and/or 
% perform coordinated actions. 
% 
% 
%% 2. Explain what composition and inheritance are. Explain why using composition is preferrable over inheritance.
% 
% 
% 
% 
% Composition is when a class (composite) has a dependence with an object or 
% objects from another class (component). This establishes a HAS A  relation between 
% classes in the way that, the composite is dependent of the component, and the 
% component is a part of the composite. For example, if there is a class _door_ 
% and a class _nob_, the _door_ has a _nod_ which means that an instance of the 
% class _nob_ can be used to form the class _door_.
% 
% On the other hand, inheritance sets an _is a_ type of relation between classes. 
% It is useful when, from a generic class, for example _animal_, we want to create 
% a more specific class, for example _bird._ In this case, the class _bird_ would 
% inherit the structure and applications of the class _animal_, this way, the 
% code is more efficient.
% 
% Using composition is preferable over inheritance for a lot of reasons. The 
% first one is the easy-to-understand mechanic of the composition, as its use 
% is straightforward and can be easily imagined. However, in the case of inheritance, 
% it can be more abstract and complex. Another point to use composition over inheritance 
% is the security, as if inheritance is used incorrectly, it can use methods from 
% the inherit class in a way that they were not meant to be used, or even worse, 
% make undesirable changes to the class. The versatility and adaptability of the 
% composition method is much grater than in the inheritance method. Even thought, 
% inheritance has more potential than Composition, seeing that composition is 
% easier to understand, safer to use and requires less attention when coding, 
% we can say that it is preferable than inheritance in the bast majority of cases. 
% 
% 
%% 3.Explain what the different types of data access are. Explain why favoring private properties and methods is considered a good coding practice.
% 
% 
% The different types of data are:
%% 
% * Public: The method/attribute can be accessed by any class/code
% * Private: The method/attribute can be accessed only within its own class
% * Protected: Like private but with the difference that derived classes (inheritance) 
% can access/change the method/attribute
% * Package-Private: The method/attribute can be accessed only within its own 
% package (project)
%% 
% Using private properties and methods is a good coding practice because limiting 
% the access to these methods/attributes ensures an extra layer of security, not 
% allowing external code to alter the values of the class. It also helps with 
% the inheritance control, as it helps ensure that the use that the derivate class 
% do of the arguments is what was intended in the first place. Private values 
% also ensure that the main code does not interfere with the internal working 
% of a class, which means that changes can be made in the class without having 
% to alter the main code. 
% 
% 
%% 4. <https://github.com/SwanLab/Swan/blob/master/FEM/computemasterslave.m This code> and <https://github.com/SwanLab/Swan/blob/c1bfb2a22b5e17a3bcadd77b45bc0614f4152199/FEM/Preprocess/MasterSlaveRelator.m this code> perform similar actions, but the second follows an object-oriented approach. Explain the difference between the private methods in lines 31-75 and the method in line 81 (_hint: look at lines 29 and 79_).
% 
% 
% The private methods in lines 31-75 have the access set to private in line 
% 29. This means that these methods can only be accessed by other methods of the 
% same class. These methods require an object of the class to be executed (_object_of_class.method_). 
% The method in the line 81 is set to private static, that means that it can only 
% be accessed by methods of the same class and, in opposition with the other methods, 
% it doesn't require of an object to be executed and can be call directly with 
% the format _class_name.static_method._
% 
% 
%% 5. Take a look at <https://github.com/SwanLab/Swan/blob/c1bfb2a22b5e17a3bcadd77b45bc0614f4152199/FEM/Preprocess/MasterSlaveRelator.m this class>, <https://github.com/SwanLab/Swan/blob/master/FEM/Problem/ElasticProblem.m this class> and <https://github.com/SwanLab/Swan/blob/01036402f3bf9ba6bca3461d343c46f81005ca03/FEM/Mesh/Symmetrizer.m this class>. List all the design patterns that you notice, as well as any clean code practices you find.
% 
% 
% The first design pattern that stands out is the way that the class is structured. 
% First the public attributes are defined, then the private ones and finally, 
% the protected attributes are deffined. Next, the public methods are deffined, 
% following them, the private method without static are dfined and at last, the 
% private methods with static are also deffined. 
% 
% Another practcie that stands out, is the tabulation, all the code has a heriarchi 
% marked with tabulations. This would be  classified as a clean code practice.  
% In some methods there has been an effort to mantain the good visability of the 
% code, for example, there are a lot of cases where spaces have been used to align 
% the equal simbol to facilitate the reading. 
% 
% The name of the variables are short and selfexplicatory, making it easyer 
% to understand the function of such variables.  The same can be said about the 
% name of the functions and the classes. 
% 
% 
%% 6. Time to create your first class and include it in the code:
% 
%% 
% * The goal is to replace the lines which compute the global stiffness matrix.
% * These lines will be replaced by the _GlobalStiffnessMatrixComputer_ class, 
% which will take four arguments: the matrix of elemental stiffness matrices _Kelem_, 
% the nodal connectivities matrix _Tnod_, the number of nodes and the number of 
% degrees of freedom at each node.
% * Create and use previous class in your code to compute the global stiffness 
% matrix.

classdef GlobalStiffnessMatrixComputer < handle

    properties (Access = private)
        k_global
        F_global
    end

    methods (Access = public)
        
        function obj = GlobalStiffnessMatrixComputer(Kel,Tnodal,nnod, ndof,fel)
            obj.Calc_matrix (Kel,Tnodal,nnod, ndof,fel);
        end
        function [K_g,F_g] = return_matrix (obj)
            K_g = obj.k_global;
            F_g = obj.F_global;
        end
    end

    methods (Access = private)
        function obj = Calc_matrix(obj,Kel,Tnodal,nnod, ndof,fel)
            F_g = zeros(ndof*nnod,1);
            K_g = zeros(ndof*nnod,ndof*nnod);
            for e = 1:(size (Tnodal,1)) 
                for i = 1:(2*ndof)
                    F_g(Tnodal(e,i)) = F_g(Tnodal(e,i)) + fel(i,e);
                    for j = 1:(2*ndof)
                        K_g(Tnodal(e,i),Tnodal(e,j)) = K_g(Tnodal(e,i),Tnodal(e,j)) + Kel(i,j,e);
                    end
                end
            end
            obj.F_global = F_g;
            obj.k_global = K_g;
        end
    end
end
%% 
% This code has been desinged and testet in the folder Practica1
% 
% 
%% 7. Time to go one step further and create the following set of classes to include in the code:
% 
%% 
% * The goal is to replace the line which calculates the displacements _uL_ 
% at the free nodes, which is located in your your _solve system_ function.
% * It will be replaced by the _Solver_ class, which will take two arguments: 
% a generic LHS matrix and a generic RHS vector, such that _LHS · x = RHS_
% * Create a _DirectSolver_ class with a function that solves the system of 
% equations directly.
% * Create an _IterativeSolver_ class with a function that solves the system 
% of equations iteratively, using MATLAB's |pcg| function.
% * Create a _Solver_ class. This class will act as the parent class of the 
% two solvers that you have previously created. Implement a method to create either 
% a Direct or an Iterative solver, using a simple |switch| structure.
% * Use this _Solver_ class in your code to calculate _uL_.
%% 
% Solver class:

classdef Solverclass < handle
    properties(Access = private)
        uL
    end
    methods (Access = public)
        function  obj = Solverclass (option,LHS,RHS)
            switch option
                case 0
                    a = DirectSolver (LHS,RHS);
                    obj.uL = a.return_value;
                otherwise
                    b = IterativeSolver (LHS,RHS);
                    obj.uL = b.return_value;
            end

        end
        
        function [uL] = return_value (obj)
            uL = obj.uL;
        end
    end

end


%% 
% Iterative solver class:

classdef IterativeSolver < handle

    properties
        uL
    end

    methods (Access = public)
        function obj = IterativeSolver (LHS,RHS)
            obj.solver(LHS,RHS);
        end
        function [uL] = return_value(obj)
            uL = obj.uL;
        end
    end
    methods (Access = private)
        function solver (obj, LHS, RHS)
            obj.uL = pcg(LHS,RHS);
        end
    end 
end
%% 
% Direct solver class

classdef DirectSolver < handle
    properties (Access = private)
        uL
    end

    methods (Access = public)
        function [obj] = DirectSolver (LHS,RHS)
            obj.solver (LHS,RHS);
        end
        function [uL] = return_value (obj)
            uL = obj.uL;
        end

    end

    methods (Access = private)
        function solver (obj,LHS,RHS)
            %obj.u = inv(LHS)*RHS
            obj.uL = LHS/RHS;
        end
    end
end

%% 
% 
% 
% 
% 
%