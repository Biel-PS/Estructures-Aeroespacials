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
% GLOBAL STIFFNESS MATRIX
stiffVariables.Tnodal = Td;
stiffVariables.data = data;
stiffVariables.Tn = Tn;
stiffVariables.m = m;
stiffVariables.Tm = Tm;
stiffVariables.nDOFnode = data.ni;
stiffVariables.nNode = data.nnod;
stiffVariables.x = x;



stiff = GlobalStiffnessMatrixComputer(stiffVariables);
kGlobal = stiff.compute();

%ELEMENT FORCE

ElementForceVariables.data = data;
ElementForceVariables.x = x;
ElementForceVariables.Tn = Tn;
ElementForceVariables.Tm = Tm;
ElementForceVariables.m = m;

fElm = ElementForceComputer.compute (ElementForceVariables);

%GLOBAL FORCE 

GlobalForceVariables.Td = Td;
GlobalForceVariables.data = data;
GlobalForceVariables.fElm = fElm;
GlobalForceVariables.fExternal = F;
GlobalForceVariables.Tn = Tn;
GlobalForceVariables.x = x;
GlobalForceVariables.Tm = Tm;
GlobalForceVariables.m = m;

GlobalForce = GlobalForceComputer(GlobalForceVariables);
fGlobal = GlobalForce.compute();

% BOUNDARY CONDITIONS

[up,vp] = BoundaryConditionsApplyer.apply(p,data.ni);

%SOLVE DISPLACEMENTS & REACTIONS

vf = setdiff((1:data.ndof)',vp);
u = zeros(data.ndof,1);
u(vp) = up;

solverVariables.LHS = kGlobal(vf,vf);
solverVariables.RHS = fGlobal(vf) - kGlobal(vf,vp)*u(vp);
solverVariables.type = 'direct';
solverVariables.vf = vf;

solver = Solver.create(solverVariables);
u = solver.compute();

forceDataSet.K = kGlobal;
forceDataSet.u = u;
forceDataSet.f = fGlobal;

solveReaction = ReactionForceComputer (forceDataSet);
fReaction = solveReaction.compute();

% 2.5 Compute stress

stressComputerVariables.data = data;
stressComputerVariables.x = x;
stressComputerVariables.Tn = Tn;
stressComputerVariables.m = m;
stressComputerVariables.Tm = Tm;
stressComputerVariables.Td = Td;
stressComputerVariables.u = u;

stress = StressComputer(stressComputerVariables);

sig = stress.compute();

%% 3) POSTPROCESS

scale = 1; % Set a number to visualize deformed structure properly
units = 'MPa'; % Define in which units you're providing the stress vector

plot2DBars(data,x,Tn,u,sig,scale,units);
