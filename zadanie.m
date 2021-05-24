global save;
global comp_with_ode45;
save = true;
comp_with_ode45 = true;

a = [0, 20];
h = 0.01;
eps = [10e-10, 10e-10];

x0a = [7, 8];
x0b = [0, 0.2];
x0c = [6, 0];
x0d = [0.01, 0.001];


[t, x] = prezentacja(@RK4zmienna, @func, a, h, x0d, eps);