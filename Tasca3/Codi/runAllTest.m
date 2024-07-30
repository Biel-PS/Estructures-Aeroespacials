clear;clc;

load("stiffnesTestVariables.mat","cParams");

stiffness = stiffnessTest();
force = forceTest ();
displacement = displacementTest ();

stiffness.runTest();
force.runTest();
displacement.runDirectTest();
displacement.runIterativeTest();