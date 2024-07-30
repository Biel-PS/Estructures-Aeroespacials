%% STRUCTURAL PROBLEM CODE STRUCTURE

clear
close all

%% 1) PREPROCESS

% 1.1 Input data (define your input parameters here)
data.ni = 2;  % Degrees of freedom per node
data.w = 75*9.81;

% 1.2 Build geometry (mesh)
% Nodal coordinates matrix
x = [% column_1 = x-coord , column_2 = y-coord , ...    
        0        0
    0.459   -0.054
    1.125        0
    0.315    0.486
    0.864    0.486
];


data.nnod = size(x,1); % Number of nodes 
data.nd = size(x,2);   % Problem dimension
data.ndof = data.nnod*data.ni;  % Total number of degrees of freedom

% Nodal connectivities matrix
Tn = [% column_1 = element node 1 , column_2 = element node 2, ...
    1 2
    2 5
    3 5
    1 4
    2 4
    4 5

];
data.nel = size(Tn,1); % Number of elements 
data.nne = size(Tn,2); % Number of nodes in a bar

% Create degrees of freedom connectivities matrix
Td = connectDOF(data,Tn);

% Material properties matrix
A1 = pi/4*((36+(1.5))^2 - (36-(1.5))^2);
A2 = pi/4*((30+(1.2))^2 - (30-(1.2))^2);
A3 = pi/4*((20+(1.0))^2 - (20-(1.0))^2);

m = [% Each column corresponds to a material property (area, Young's modulus, etc.)
    71e3 A1 0
    71e3 A2 0
    71e3 A3 0
];

% Material connectivities matrix
Tm = [% Each row is the material (row number in 'm') associated to each element
    3
    1
    1
    3
    2
    2
];

% 1.3 Input boundary conditions
% Fixed nodes matrix
p = [% Each row is a prescribed degree of freedom | column_1 = node, column_2 = direction, column_3 = value of prescribed displacement
    1 1 0
    1 2 0
    3 1 0
    3 2 0
];

% Point loads matrix
F = [% Each row is a point force component | column_1 = node, column_2 = direction (1 = x-direction, 2 = y-direction), column_3 = force magnitude
    2 2 -0.45*data.w;
    4 2 -0.5*data.w;
    5 1 2.5*data.w/9.81;
    5 2 -0.05*data.w;
];

%% 2) SOLVER

% 2.1.1 Compute element stiffness matrices
s.data = data;
s.x = x;
s.Tn = Tn;
s.m = m;
s.Tm = Tm;


s.Tnodal = Td;
s.nDOFnode = data.ni;
s.nNode = data.nnod;



 kElementRef = stiffnessFunction(data,x,Tn,m,Tm);
% stiffnessFunction_parameters.kElm = Kel;

% 2.1.2 Compute element force vectors


 fElm = forceFunction(data,x,Tn,m,Tm); 

% 2.2 Assemble global stiffness matrix

GlobalForceComputerTestVariables.Td = Td;
GlobalForceComputerTestVariables.data = data;
GlobalForceComputerTestVariables.fElm = fElm;
GlobalForceComputerTestVariables.fExternal = F;


 [kGlobalRef,fRef] = assemblyFunction(data,Td,kElementRef,fElm);


% cParams.Tnodal = Td;
% cParams.nDOFnode = data.ni;
% cParams.nNode = data.nnod;
% cParams.kElm = Kel;

assembly = GlobalStiffnessMatrixComputer(s);
K = assembly.compute();

restrictedDofMatrix = p;
nDofElement = data.ni;

% 2.3.1 Apply prescribed DOFs
[upRef,vpRef] = applyBC(data,p);



% 2.3.2 Apply point loads
fRef = pointLoads(data,fRef,F);

% 2.4 Solve system


vf = setdiff((1:data.ndof)',vp);
u = zeros(data.ndof,1);
u(vp) = up;

[u,r] = solveSystem(data,K,f,up,vp);

% ReactionForceTest_variables.data = data;
% ReactionForceTest_variables.K = K;
% ReactionForceTest_variables.f = f;
% ReactionForceTest_variables.up = up;
% ReactionForceTest_variables.vp = vp;
% ReactionForceTest_variables.u = u;
% 
% ReactionForceTest_variables.LHS = K(vf,vf);
% ReactionForceTest_variables.RHS = f(vf) - K(vf,vp)*u(vp);
% ReactionForceTest_variables.vf = vf;


dataIn.LHS = K(vf,vf);
dataIn.RHS = f(vf) - K(vf,vp)*u(vp);
dataIn.vf = vf;
dataIn.type = "iterative";


solver = Solver.create (dataIn);
uL = solver.compute();

forceDataSet.K = K;
forceDataSet.u = u;
forceDataSet.f = f;

solve_force = ReactionForceComputer (forceDataSet);
r_class = solve_force.compute();

% 2.5 Compute stress
sig = stressFunction(data,x,Tn,m,Tm,Td,u);

%% 3) POSTPROCESS

scale = 1; % Set a number to visualize deformed structure properly
units = 'MPa'; % Define in which units you're providing the stress vector

plot2DBars(data,x,Tn,u,sig,scale,units);