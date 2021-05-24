a = [0, 20];
h = 0.001;
x0 = [0, -1];

global save;
global comp_with_ode45;
save = true;
comp_with_ode45 = true;
[t, x] = prezentacja(@PK4adams, @func, a, h, x0);