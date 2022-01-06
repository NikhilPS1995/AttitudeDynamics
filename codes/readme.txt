List of functions:

1.main:
Run this file to simulate the dynamics
Asks for Moment of inertia tensor, mass, initial conditions, time step for simulation, and Moment series
Moment is applied in along the body fixed axes.

Press enter to use default values or provide with values
Contains plotting and animation tools

2.SolveImplicitMatrixEqn
Solves the implicit nonlinear matrix equation in F_k.
Uses a Newton Raphson like algorithm
Preserves the structure of F_k 
 
3.check_inertia
Checks if the provided inertia matrix satisfies all the properties of a Physical Inertia matrix and the mass

4.check_initial_conditions
Checks if the initial conditions are numeric,real and have the right dimensions

5.check_h
Checks if the provided time step is numeric,scalar and positive

6.check_Moment
Checks if the provided moment series is numeric,real and has the right dimensions

7.skewfun
Vector space homeomorphism from 3x1 vector to a 3x3 skew symmetric matrix

8.veemap
Vector space homeomorphism from 3x3 skew symmetric matrix to a 3x1 vector
It is the inverse map of the skewfun function



