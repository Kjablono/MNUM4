% PK4adams.m
% Autor: Kamil Jabłonowski
% funkcja wyznacza rozwiązanie układu równań różniczkowych o dowolnej
% wymiarowości metodą wielokrokową Predyktor-Korektor Adamsa ze stałym
% krokiem
% 
% zmienne wejściowe:
% f - uchwyt do funkcji opisującej układ równań różniczkowych
%   funkcja f jest postaci [y] = f(x), gdzie
%   y - wektor kolumnowy pochodnych xi'
%   f(x) = f(x1, x2,..., xn)
% a = [t0, tk] - przedział na którym rozwiązywane jest rozwiązanie
%   t0 - początek przedziału
%   tk - koniec przedziału
% x0 - wektor warunków brzegeowych [x00(t0), x01(t0),.. x0n(t0)]
% h - stały krok
%
% zmienne wyjściowe:
% t - wektor wartości t w których wyznaczone zostały przybliżenia zmiennych
% układu równań różniczkowych
% x - macierz wartości x, kolejne wiersze odpowiadają kolejnym chwilom
% czasu t, kolumny odpowiadają kolejnym zmiennym x1, x2,.. ,xn

function [t, x] = PK4adams(f, x0, a, h, ~)

    % wartości współczynników beta dla metody Adamsa 4 rzędu
    betap = [55/24, -59/24, 37/24, -9/24];                      % dla predyktora (metoda Adamsa jawna)
    betak = [251/720, 646/720, -264/720, 106/720, -19/720];     % dla korektora (metoda Adamsa niejawna)
    
    n = length(x0);                                             % wymiarowość układu
    t = (a(1):h:a(2))';                                         % chwile czasu w których wyznaczane będą wartości
    x = zeros(length(t), n);                                    % macierz na rozwiązania x(i,j) - wartość j-tej funkcji w chwili i
    
    % wyznaczenie pierwszych czterech wartości algorytmem RK4klasyczna
    if (a(2) < a(1) + 3 * h)
        error("Zbyt duży krok algorytmu, metoda nieskuteczna");
    end
    % [~, x(1:4, :)] = RK4klasyczna(f, x0, [a(1), a(1) + 3*h], h, eps);
    x(1, :) = x0;
    for i = 1:3 
        k(1, :) = f(t(i), x(i, :));
        k(2, :) = f(t(i) + 0.5 * h, x(i, :) + 0.5 * h * k(1, :));
        k(3, :) = f(t(i) + 0.5 * h, x(i, :) + 0.5 * h * k(2, :));
        k(4, :) = f(t(i) + h, x(i, :) + h * k(3, :));
        
        x(i + 1, :) = x(i, :) + (1 / 6) * h * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));        
    end
    
    % Predyktor - Korektor
    for i = 5:length(t)
        % predykcja i ewaluacja
        tmp = zeros(1, n);
        for j = 1:4
            tmp = tmp + betap(j) * f(t(i - j), x(i - j, :))';
        end
        xp = x(i - 1, :) + h * tmp;
        % korekcja i ewaluacja
        tmp = zeros(1, n);
        for j = 1:4
            tmp = tmp + betak(j + 1) * f(t(i - j), x(i - j, :))';
        end
        x(i, :) = x(i - 1, :) + h * (tmp + betak(1) * f(t(i), xp)');  
    end
end