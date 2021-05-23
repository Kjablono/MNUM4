a = [0, 20];
h = 0.01;
x0 = [-1, 0];

global save;
global comp_with_ode45;
save = true;
comp_with_ode45 = false;
[t, x] = prezentacja(@PK4adams, @func, a, h, x0);