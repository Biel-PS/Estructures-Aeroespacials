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
Kel = stiffnessFunction(data,x,Tn,m,Tm);

% 2.1.2 Compute element force vectors
fel = forceFunction(data,x,Tn,m,Tm); 

% 2.2 Assemble global stiffness matrix
[K,f] = assemblyFunction(data,Td,Kel,fel);

% 2.3.1 Apply prescribed DOFs
[up,vp] = applyBC(data,p);

% 2.3.2 Apply point loads
f = pointLoads(data,Td,f,F);

% 2.4 Solve system
[u,r] = solveSystem(data,K,f,up,vp);

% 2.5 Compute stress
sig = stressFunction(data,x,Tn,m,Tm,Td,u);

%% 3) POSTPROCESS

scale = 1000; % Set a number to visualize deformed structure properly
units = 'MPa'; % Define in which units you're providing the stress vector

plot2DBars(data,x,Tn,u,sig,scale,units);
reactions = -r;



%% Part2

%% 1) PREPROCESS

% 1.1 Input data (define your input parameters here)
data.ni = 2;  % Degrees of freedom per node


% 1.2 Build geometry (mesh)
% Nodal coordinates matrix
x = [% column_1 = x-coord , column_2 = y-coord , ...    
        0        0
    0.459   -0.054
    1.125        0
    0.315    0.486
    0.864    0.486
];


radi_rodes = 0.35; %radi de les rodes en metres
nombre_nodes_roda = 9; %nombre de nodes contant el node central

x_roda1 = Deffine_Geometry (radi_rodes, nombre_nodes_roda, x(1,1), x(1,2)); %definim les coordenades del punt central al node 1 del apartat 1
x_roda2 = Deffine_Geometry (radi_rodes, nombre_nodes_roda, x(3,1), x(3,2)); %definim les coordenades del punt central al node 3 del apartat 1
% figure;
% scatter(x_roda1(:,1),x_roda1(:,2)); %Visión del mapa de puntos generados
% por Deffine_Geometry de la rueda 1
total_initial_stress = zeros(2,1);    

sig0 = 0;
safety_factor = 2.5; %Factor de seguretat  
max_iterations =10; %per calcular sense sigma0,igualar a -1
resolution_value = 1E-6; %Valor a partir del qual es considera que la tensió real es equivalent a l'admisible

for l = 1:2
    pre_stress_needed = 1; %NO TOCAR, parametro de control
    cont = 0;
    
    if l == 1
            x = x_roda1;
        else
            x = x_roda2;
    end
    data.nnod = size(x,1); % Number of nodes 
        data.nd = size(x,2);   % Problem dimension
        data.ndof = data.nnod*data.ni;  % Total number of degrees of freedom
        
        % Nodal connectivities matrix
        Tn = [% column_1 = element node 1 , column_2 = element node 2, ...
            1 2
            2 3
            3 4
            4 5
            5 6
            6 7
            7 8
            8 1
            1 9
            2 9
            3 9
            4 9
            5 9
            6 9
            7 9
            8 9
        ];
        data.nel = size(Tn,1); % Number of elements 
        data.nne = size(Tn,2); % Number of nodes in a bar
        
        % Create degrees of freedom connectivities matrix
        Td = connectDOF(data,Tn);
        
        % Material properties matrix

Tm = [% Each row is the material (row number in 'm') associated to each element
            1 
            1
            1
            1
            1
            1
            1
            1
            2
            2
            2
            2
            2
            2
            2
            2
        ];
        
        % 1.3 Input boundary conditions
        % Fixed nodes matrix
        p = [% Each row is a prescribed degree of freedom | column_1 = node, column_2 = direction, column_3 = value of prescribed displacement
            6 2 0
            7 1 0
            7 2 0
        ];
    A1 = 140; %UNITATS EN mm2 !!
    A2 = 3.8;
    while (true)
        cont = cont+1;
         % Point loads matrix
       if l == 1 %Diferenciem entre les dues rodes
            F = [% Each row is a point force component | column_1 = node, column_2 = direction (1 = x-direction, 2 = y-direction), column_3 = force magnitude
            9 1 reactions(1,1);
            9 2 reactions(2,1);
        ];
            m = [% Each column corresponds to a material property (area, Young's modulus, inertia)
            70e3 A1 0 1470
            210e3 A2 sig0 1.15
        ]; %UNITATS EN MPa I mm !!
        else
            F = [
            9 1 reactions(3,1);
            9 2 reactions(4,1);
        ];
            m = [
            70e3 A1 0 1470
            210e3 A2  sig0 1.15
        ]; 
        end
        % Material connectivities matrix
       
        %% 2) SOLVER
        
        % 2.1.1 Compute element stiffness matrices
        Kel = stiffnessFunction(data,x,Tn,m,Tm);
        
        % 2.1.2 Compute element force vectors
        fel = forceFunction(data,x,Tn,m,Tm); 
        
        % 2.2 Assemble global stiffness matrix
        [K,f] = assemblyFunction(data,Td,Kel,fel);
        
        % 2.3.1 Apply prescribed DOFs
        [up,vp] = applyBC(data,p);
        
        % 2.3.2 Apply point loads
        f = pointLoads(data,Td,f,F);
        
        % 2.4 Solve system
        [u,r] = solveSystem(data,K,f,up,vp);
        
        % 2.5 Compute stress
        sig = stressFunction(data,x,Tn,m,Tm,Td,u);
    
        crit_tension = Critical_tension(m,Tm,data,x,Tn);
        
        %% 3) POSTPROCESS
        
        

       if (abs(pre_stress_needed) <= resolution_value)%Definim el valor a partir del qual s'enten que la solució es convergent
            break
       end 
       if cont >= max_iterations && max_iterations ~= 0 %Condició d'excepció 
          disp('CUIDADO: No se pudo obtener una solución convergente, aumente el número de iteraciones máximas ')
          break
       end 
       
          
       max_crit_tension = max(crit_tension(size(crit_tension,1)/2+1:end,1)); %Dels spokes, es troba el valor crític on la tensió (valor absolut) es menor
       admisible_tension = max_crit_tension/safety_factor; %Es troba la tensió (a compressió) màxima admissible
       pre_stress_needed = admisible_tension-min(sig(size(sig,1)/2+1:end,1)); %Es calcula la tensió inicial a tracció que s'ha d'aplicar (sense considerar l'efecte de les forces de tensió)

       sig0 = pre_stress_needed + sig0; %S'afegeix el valor calculat als valors de tensió inicial anteriors
    end 
    total_initial_stress (l,1) = sig0; %Vector de tensións inicials aplicades.
    scale = 100; % Set a number to visualize deformed structure properly
    units = 'MPa'; % Define in which units you're providing the stress vector
    plot2DBars(data,x,Tn,u,sig,scale,units);
end
total_initial_stress