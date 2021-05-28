% zadanie.m
% Autor: Kamil Jabłonowski
% skrypt uruchamiający funkcję prezentacja oraz ustawiający odpowiednie
% zmienne
% zmienna save oznacza zapisywanie wykresów do plików. Jednakże aby
% to się udało, należy ręcznie stworzyć katalogi w folderze projektu w
% formacie ./plots/[y01_y02_..._y0n]/nazwa_solvera/
% gdzie y01, y02, .., y0n - wartości punktów startowych
% nazwa_solvera - nazwa metody wykorzystywanej do znajdowania rozwiązania
global save;                % czy wykonać zapis wykresów w folderze ./plots
global comp_with_ode45;     % czy porównywać z funkcją ode45
save = false;
comp_with_ode45 = true;


a = [0, 40];                % przedział szukania rozwiązań
h = 0.5;                   % krok (lub krok początkowy dla metod ze zmiennym krokiem)
eps = [10e-8, 10e-8];       % wartości współczynników błędów do funkcji ze zmiennym krokiem
x0 = [-0.03, 0.03];

% wartości kroków wykorzystane w sprawozdaniu. Ostatnia wartość w wektorze
% jest wartością oznaną za optymalną
ha_RK4klasyczna = [0.1; 0.02116; 0.015; 0.01; 0.007];
hb_RK4klasyczna = [0.5; 0.25; 0.1];
hc_RK4klasyczna = [0.1; 0.0668; 0.04; 0.021];
hd_RK4klasyczna = [1; 0.5; 0.25];

ha_PK4adams = [0.1; 0.02065; 0.01; 0.008];
hb_PK4adams = [0.5; 0.2];
hc_PK4adams = [0.1; 0.0667; 0.03; 0.0175];
hd_PK4adams = [0.5; 0.25];

ha_RK4zmienna = 0.06;
hb_RK4zmienna = 1;
hc_RK4zmienna = 0.1;
hd_RK4zmienna = 1;

x0a = [7, 8];               % warunki brzegowe dla podpunktu a)
x0b = [0, 0.2];             % warunki brzegowe dla podpunktu b)
x0c = [6, 0];               % warunki brzegowe dla podpunktu c)
x0d = [0.01, 0.001];        % warunki brzegowe dla podpunktu d)

x0mock = [0, 1, 1];

% wołanie funkcji (@nazwa_solvera, @funkcja, przedział, krok, warunki_brzegowe, współczynniki_błędów)
[t, x] = prezentacja(@RK4zmienna, @mockfun, a, h, x0mock, eps);



