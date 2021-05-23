a = [0, 20];
h = 0.01;
x0 = [-1, 0];

global save;
global comp_with_ode45;
save = true;
comp_with_ode45 = true;
[t, x] = prezentacja(@RK4klasyczna, @func, a, h, x0);