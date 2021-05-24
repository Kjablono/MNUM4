a = [0, 20];
h = 0.001;
x0 = [7, 8];

global save;
global comp_with_ode45;
save = true;
comp_with_ode45 = true;
[t, x] = prezentacja(@RK4zmienna, @func, a, h, x0, [10e-12, 10e-12]);