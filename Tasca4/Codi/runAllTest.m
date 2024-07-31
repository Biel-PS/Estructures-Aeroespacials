clear;clc;
%%
% DISPLACEMENT TEST
tolerance = 1e-10;


% force = forceTest ();

load ("DisplacementSolverTestVariables.mat","dataIn","u");
DisplacementSolverTest.runIterativeTest(dataIn,u,tolerance);
DisplacementSolverTest.runDirectTest(dataIn,u,tolerance);



%%
% STIFFNESS MATRIX RELATED TESTS
clear;
tolerance = 1e-10;

load ("stiffnessMatrixTest.mat",'s','kElementRef','kGlobalRef'); 

ElementStiffnessComputerTest.runTest(s,kElementRef,tolerance);
GlobalStiffnessComputerTest.runTest(s,kGlobalRef,tolerance);


%%
% FORCE RELATED TESTS
clear;
tolerance = 1e-10;
load ("ElementForceComputerTestVariables.mat","ElementForceComputerTestVariables","fel")
ElementForceComputerTest.runTest(ElementForceComputerTestVariables,fel,tolerance);

clear;
tolerance = 1e-10;
load ("GlobalForceComputerTestVariables.mat", "GlobalForceComputerTestVariables","fRef");
GlobalForceComputerTest.runTest (GlobalForceComputerTestVariables,fRef,tolerance);

%%
% BOUNDARY CONDITIONS TEST
clear;
tolerance = 1e-10;
load ("BoundaryConditionsApplyerTestVariables.mat", "nDofElement","restrictedDofMatrix","upRef","vpRef");
BoundaryConditionsApplyerTest.runTest(restrictedDofMatrix,nDofElement,upRef,vpRef,tolerance);

%%
% STRESS TEST
clear;
tolerance =  1e-10;
load ("stressComputerTestVariables.mat","stressComputerTestVariables","sigRef");
StressComputerTest.runTest(stressComputerTestVariables,sigRef,tolerance);