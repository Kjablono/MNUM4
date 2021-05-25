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


a = [0, 20];                % przedział szukania rozwiązań
h = 0.25;                   % krok (lub krok początkowy dla metod ze zmiennym krokiem)
eps = [10e-8, 10e-8];     % wartości współczynników błędów do funkcji ze zmiennym krokiem

x0a = [7, 8];               % warunki brzegowe dla podpunktu a)
x0b = [0, 0.2];             % warunki brzegowe dla podpunktu b)
x0c = [6, 0];               % warunki brzegowe dla podpunktu c)
x0d = [0.01, 0.001];        % warunki brzegowe dla podpunktu d)

x0mock = [0, 1, 1];

% wołanie funkcji (@nazwa_solvera, @funkcja, przedział, krok, warunki_brzegowe, współczynniki_błędów)
[t, x] = prezentacja(@PK4adams, @func, a, h, x0d, eps);