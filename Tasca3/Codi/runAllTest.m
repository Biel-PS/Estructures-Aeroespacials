clear;clc;
stiffness = stiffnessTest();
force = forceTest ();
displacement = displacementTest ();

stiffness.runTest();
force.runTest();
displacement.runDirectTest();
displacement.runIterativeTest();