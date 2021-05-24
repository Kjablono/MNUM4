% zadanie.m
% Autor: Kamil Jabłonowski
% skrypt uruchamiający funkcję prezentacja oraz ustawiający odpowiednie
% zmienne
global save;
global comp_with_ode45;
save = false;
comp_with_ode45 = true;


a = [0, 20];                % przedział szukania rozwiązań
h = 0.01;                   % krok (lub krok początkowy dla metod ze zmiennym krokiem)
eps = [10e-10, 10e-10];     % wartości współczynników błędów do funkcji ze zmiennym krokiem

x0a = [7, 8];               % warunki brzegowe dla podpunktu a)
x0b = [0, 0.2];             % warunki brzegowe dla podpunktu b)
x0c = [6, 0];               % warunki brzegowe dla podpunktu c)
x0d = [0.01, 0.001];        % warunki brzegowe dla podpunktu d)


[t, x] = prezentacja(@RK4zmienna, @func, a, h, x0d, eps);