clc; clear;

a = mainCode();
[Stress,Reactions] = a.compute();
a.plot();