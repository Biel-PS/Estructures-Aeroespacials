%% 3D BARS STRUCTURE - GLIDER
% BIEL PUJADAS SURIOL / JUDITH BAILEN LOZANO

clear
close all

%% 1) PREPROCESS

% 1.1 Input data (define your input parameters here)
data.ni = 3;  % Degrees of freedom per node
g = 9.81;

% 1.2 Build geometry (mesh)
% Nodal coordinates matrix

[x,Tn,Tm] = input_data();

data.nnod = size(x,1); % Number of nodes 
data.nd = size(x,2);   % Problem dimension
data.ndof = data.nnod*data.ni;  % Total number of degrees of freedom

data.nel = size(Tn,1); % Number of elements 
data.nne = size(Tn,2); % Number of nodes in a bar

% Material properties matrix
D1 = 2.5e-3;
D2 = 14e-3;
D2_int = 10e-3;

A1 = pi/4*D1^2;
A2 = pi/4*(D2^2-D2_int^2);
I1 = pi*D1^4/64;
I2 = pi/64*(D2^4-D2_int^4);

CL_upper_surface = 2.6;
CD_upper_surface = 1.45;
Surface = 3.75; %[m2]
Surface_density = 1.55; %[kg/m2]
 %ALL IN INTERNATIONAL UNITS!!!
m = [% Young, Area, Pre_tens, DENSITY ,Yield Strenght, Inertia Cross Section
    150e9 A1 0 1500 150e6 I1 % Cables
    78e9 A2 0 2600 240e6 I2  % Bars
];

rho_air = 1.225;
%Symbolic definitions

Vx = sym('Vx','real');
Vy = sym('Vy','real');
Vz = sym('Vz','real');

%% DYNAMIC PROBLEM %%

%% 1.1 Find M_total and I_cm

Lift = 0.5*rho_air*Surface*CL_upper_surface*Vz^2;
Drag = 0.5*rho_air*Surface*CD_upper_surface*Vz^2;

M_e = zeros (data.nel,1);
L_e = zeros (data.nel,1);

for i = 1:data.nel
    xel=x(Tn(i,:),:);
    deltax=xel(2,1)-xel(1,1);
    deltay=xel(2,2)-xel(1,2);
    deltaz=xel(2,3)-xel(1,3);

    L_e(i) = sqrt(deltax^2+deltay^2+deltaz^2);
    M_e (i) = L_e(i)*m(Tm(i),2)*m(Tm(i),4);

end

M_sup = Surface_density * Surface;
M_pilot = 85;
R_pilotZ = sym ('Rp_z');
R_pilotX = sym ('Rp_x');

%Now we define the Force Matrix

F = [
1 3 R_pilotZ/2
2 3 R_pilotZ/2
1 1 R_pilotX/2
2 1 R_pilotX/2
3 1 -Drag*1/3
3 3 0
4 1 -Drag*1/3
4 3 0
5 1 -Drag*1/6
5 3 0
6 1 -Drag*1/6
6 3 0
];

F_Lift = [
0
0
0
0
0
Lift*1/3
0
Lift*1/3
0
Lift*1/6
0
Lift*1/6
];

F_mass = [
(-M_pilot/2-M_e(1)/2-M_e(11)/2-M_e(7)/2-M_e(9)/2)*g  
(-M_pilot/2-M_e(1)/2-M_e(12)/2-M_e(10)/2-M_e(8)/2)*g 
 0
 0
 0
 (-M_sup*1/3-M_e(2)/2-M_e(3)/2-M_e(7)/2-M_e(8)/2-M_e(5)/2)*g
 0
 (-M_sup*1/3-M_e(2)/2-M_e(4)/2-M_e(6)/2-M_e(9)/2-M_e(10)/2)*g
 0
 (-M_sup*1/6-M_e(3)/2-M_e(4)/2-M_e(11)/2)*g
 0
 (-M_sup*1/6-M_e(5)/2-M_e(6)/2-M_e(12)/2)*g
];

F(:,3) = F_Lift + F_mass + F(:,3); 

M_total = 0;
M_total = M_total + M_pilot + M_sup + sum(M_e);

M_nod = zeros(data.nnod,1);

for i = 1:size(F,1)
    if F_mass(i) ~= 0
       M_nod(F(i,1)) = abs(F_mass(i))/g;
    end
end

x_cdg = 0;
y_cdg = 0;
z_cdg = 0;

for i=(1:data.nnod)
    x_cdg = x_cdg + x(i,1)*M_nod(i)/M_total;
    y_cdg = y_cdg + x(i,2)*M_nod(i)/M_total;
    z_cdg = z_cdg + x(i,3)*M_nod(i)/M_total;
end

cdg = [x_cdg y_cdg z_cdg];

I = zeros(3,3);
%matrix with the distance in x, y, z of each node to the structure cdg
Node_delta_cdg = zeros(data.nnod,3);

for i = 1:data.nnod
    X=x(i,1)-cdg(1,1);
    Y=x(i,2)-cdg(1,2);
    Z=x(i,3)-cdg(1,3);
    Node_delta_cdg (i,:) = [X Y Z];

   I = I + [(Y^2+Z^2) -X*Y (-X*Z);-X*Y (X^2+Z^2) -Y*Z;(-X*Z) -Z*Y (X^2+Y^2)].*M_nod(i);
end
% I 
% M_total
Td = connectDOF(data,Tn);
%% Apartat 1.2 Components of the reaction force the pilot does in nodes 1 and 2
v_g = 2.4;
delta_tg = 0.7;
tg = 3;
time_step = 0.01;

tr = tg +0.5;
delta_tr = 2;
c1 = 4.512;
c2 = 6.0996;
c3 = 1.9218;

Time_end = 6.5;

Lg = 0.5*rho_air*Surface*CL_upper_surface*v_g^2;
t = linspace(0,Time_end,Time_end/time_step + 1);

delta_L = zeros (1,length(t));
delta_R = zeros (1,length(t));

delta_L_timeset = (tg/time_step +1):((tg+delta_tg)/time_step +1);
delta_R_timeset = (tr/time_step +1):((tr+delta_tr)/time_step +1);

delta_L(delta_L_timeset) = Lg * sin(pi*(t(delta_L_timeset)-tg)/delta_tg); %𝑡g < 𝑡< 𝑡g + Δ𝑡g
delta_R(delta_R_timeset) = -Lg * (c3 * (t(delta_R_timeset)-tr).^3 - c2*(t(delta_R_timeset)-tr).^2 + c1*(t(delta_R_timeset)-tr));
%plot (t(315:end),delta_R(315:end))

%Trobem les components en x and z de les forces externes (INCLOENT EL PES DE L'ESTRUCTURA)
[f_x,f_z] = Force_sorter (F,data);

%Trobem el moment total sobre el punt de gravetat
Total_moment = Moment_sorter (F,data,Node_delta_cdg);

%Per regim de treball estacionari dvx/dt = 0 i domega/dt = 0
R_pilotX_new = solve (f_x == 0,R_pilotX);
R_pilotZ_new = subs(solve (Total_moment == 0,R_pilotZ),R_pilotX,R_pilotX_new);

V_z = zeros(1,length(t));
Omega = zeros(3,length(t));


Forces_incrementals = F(:,:);
Forces_incrementals (:,3) = 0;

%Definim les condicions inicials segons marca l'enunciat
V_z(1) = 0;
Omega(:,1) = 0;
Mom_incr = [0,0,0];
a = zeros (3,data.nnod,length(t));
%trobem la posició del node 3 al vector forces
index = find(F(:,1) == 3 & F(:,2) == 3);
for i = 2:1:length(t)
    % Per optimització, definim les accions a prendre quan hi ha increment
    % de lift o de la reacció del pilot
    if delta_L(i) ~= 0
        % Sumem a la contribució del lift
        Forces_incrementals(index,3) = Forces_incrementals(index,3) + delta_L(i);
    end
    if (delta_R(i) ~= 0) | (delta_L(i) ~= 0)
        %Calculem el moment produit per les forces externes incrementals i
        %sumem, en cas que sigui no nula, la contribució de la reacció del
        %pilot
        Forces_incrementals (1:2,3) = Forces_incrementals (1:2,3) + 0.5*delta_R(i);
        Mom_incr = Moment_sorter (Forces_incrementals,data,Node_delta_cdg);
    end
        %Calculem les forces en z a partir del vector de forçes global
        %on encara no s'ha tingut en compte la contribució de les forces
        %incrementals (s'afegeix la reacció del pilot incremental en cas que hi hagi)
        f_z_new_t1 = subs(f_z, R_pilotZ,(R_pilotZ_new + delta_R(i)));
        %Formulem la segona llei de newton amb les aportacións incrementals
        %i amb la aprixmació de la derivada descrita a l'enunciat (1.4)
        Resultat_t2 = solve(f_z_new_t1+delta_L(i) == M_total*(Vz - V_z (i-1))/time_step,Vz);
        %Un cop aillada la velocitat de l'expressió anterior, pasem de
        %variables simbòliques a numériques
        V_z(i)= double(Resultat_t2(1));
        % A partir del moment de les forces incrementals i de l'equació de
        % moments, aïllem la velocitat omega de rotació de l'estuctura. Es
        % realitza la mateixa aproximació per la derivdada de omega.
        Omega(2,i) = (double(Mom_incr(2))/I(2,2))*time_step + Omega (2,i-1);
        Forces_incrementals (:,3) = 0;
        %Netejem les variables per a la futura iteració
        Mom_incr = [0,0,0];
        [Omega(2,i),t(i)]
end
ax = zeros (data.nnod,length(t));
az = zeros (data.nnod,length(t));
% Càlcul de l'acceleració
% Node_delta_cdg(j,i) es un vector amb la distància al cdg de cada node
%j = nombre noda; i = coordenada (1-x ; 2-y ; 3-z)
for i = 2:1:length(t)
    d_omega = (Omega(2,i) - Omega (2,i-1))/time_step;
    d_velz = (V_z(i) - V_z (i-1))/time_step;
    for j = 1:data.nnod
        a(:,j,i) = [0,0,d_velz] + [d_omega*Node_delta_cdg(j,3),0,-d_omega*Node_delta_cdg(j,1)] + [-Omega(2,i)^2*Node_delta_cdg(j,1),0,-Omega(2,i)^2*Node_delta_cdg(j,3)] ;
        ax(j,i) = a(1,j,i);
        az(j,i) = a(3,j,i);
    end
end

figure;
plot (t,Omega(2,:)); grid; xlabel('Temps (s)'); ylabel('Velocitat \Omega (rad/s)'); title('Velocitat angular en funció del temps');
figure;
plot (t,V_z); grid; xlabel('Temps (s)'); ylabel('Velocitat V (m/s)'); title('Velocitat lineal en funció del temps');
figure;
plot(t,delta_L,t,delta_R); grid; xlabel('Temps (s)'); ylabel('Newtons (N)'); title('Funcions increment lift i reacció del pilot'); legend('Lift','Reacció del pilot');
 %acceleració tots els nodes x


figure;
title 'Acceleració de eix X per tots els nodes';
xlabel 'Temps [s]';
ylabel 'Acceleració m/s^2';
Legend=cell(data.nnod,1);
hold on;
for i = 1:data.nnod
    plot (t,ax(i,:));
    Legend{i}=strcat('Node: ', num2str(i));
end
legend(Legend)
hold off;
%acceleració tots els nodes z


figure; 
title 'Acceleració de eix Z per tots els nodes';
xlabel 'Temps [s]';
ylabel 'Acceleració m/s^2';
Legend=cell(data.nnod,1);
hold on;
for i = 1:data.nnod
    plot (t,az(i,:));
    Legend{i}=strcat('Node: ', num2str(i));
end
legend(Legend)
hold off;



%% QUASI-STATIC PROBLEM %%

%% 2.1. Determine a set of degrees of freedom to prescribe

% 1.3 Input boundary conditions
% Fixed nodes matrix
p = [% Each row is a prescribed degree of freedom | column_1 = node, column_2 = direction, column_3 = value of prescribed displacement
    3 2 0
    3 3 0
    4 1 0
    4 2 0
    4 3 0
    6 3 0
];

Td = connectDOF(data,Tn);


%% 2.2. For each timestep, solve the structural problem to get displacements, reactions and stresses

% 2) SOLVER
% 2.1.1 Compute element stiffness matrices
Kel = stiffnessFunction(data,x,Tn,m,Tm);

sig = zeros(data.nel,length(t));
u_objects = zeros(data.ni*data.nnod,length(t));
reacts = zeros(data.nnod,length(t));

F_new = subs(F,R_pilotX,R_pilotX_new);
F_new = subs(F_new,R_pilotZ,R_pilotZ_new);
ac = zeros (3,data.nnod);

for i = 1:1:length(t)
    % 2.1.2 Compute element force vectors
    ac(:,:) = a(:,:,i);
    fel = forceFunction(data,x,Tn,m,Tm,ac,g); 

    % 2.2 Assemble global stiffness matrix
    [K,f] = assemblyFunction(data,Td,Kel,fel);

    % 2.3.1 Apply prescribed DOFs
    [up,vp] = applyBC(data,p);
    
    F_new = double(subs(F_new,Vz,V_z(i)));
    
    % 2.3.2 Apply point loads
    f = pointLoads(data,Td,f,F_new); %Td substituir per ~?
    
    % 2.4 Solve system
    [u,r] = solveSystem(data,K,f,up,vp);
    u_objects(:,i) = u;
    reacts(:,i) = r;

    % 2.5 Compute stress
    sig(:,i) = stressFunction(data,x,Tn,m,Tm,Td,u);
    t(i)
end

%% 3) POSTPROCESS

scale = 10; % Set a number to visualize deformed structure properly
units = 'Pa'; % Define in which units you're providing the stress vector
time = 350;
%plot3DBars(x,Tn,scale,t(time),u_objects(:,time),sig(:,time),units);
plot3DBars(x,Tn,scale,t(time),u,sig(:,time),units);
reactions = -reacts;

%% 2.3. Determine the safety factor for stresses at traction

sf_trac = SFtrac(m,Tm,sig);

%% 2.4. Determine the safety factor for buckling

sf_buck = SFbuck(data,x,Tn,m,Tm,sig);
