% PK4adams.m
% Autor: Kamil Jabłonowski
% funkcja wyznacza rozwiązanie układu równań różniczkowych o dowolnej
% wymiarowości metodą wielokrokową Predyktor-Korektor Adamsa ze stałym
% krokiem
% 
% zmienne wejściowe:
% f - uchwyt do funkcji opisującej układ równań różniczkowych
%   funkcja f jest postaci [yp] = f(x, y), gdzie
%   yp - wektor kolumnowy pochodnych xi'
%   f(x, y) = f(x, y1, y2,..., yn)
% a = [x0, xk] - przedział na którym rozwiązywane jest rozwiązanie
%   x0 - początek przedziału
%   xk - koniec przedziału
% y0 - wektor warunków brzegowych [y00(x0), y01(x0),.. y0n(x0)]
% h - stały krok
%
% zmienne wyjściowe:
% x - wektor wartości x w których wyznaczone zostały przybliżenia zmiennych
% układu równań różniczkowych
% y - macierz wartości y, kolejne wiersze odpowiadają kolejnym wartościom
% x, kolumny odpowiadają kolejnym zmiennym y1, y2,.. ,yn

function [x, y] = PK4adams(f, y0, a, h, ~)

    % wartości współczynników beta dla metody Adamsa 4 rzędu
    betap = [55/24, -59/24, 37/24, -9/24];                      % dla predyktora (metoda Adamsa jawna)
    betak = [251/720, 646/720, -264/720, 106/720, -19/720];     % dla korektora (metoda Adamsa niejawna)
    
    n = length(y0);                                             % wymiarowość układu
    x = (a(1):h:a(2))';                                         % chwile czasu w których wyznaczane będą wartości
    y = zeros(length(x), n);                                    % macierz na rozwiązania y(i,j) - wartość j-tej funkcji dla xi
    
    % wyznaczenie pierwszych czterech wartości algorytmem RK4klasyczna
    if (a(2) < a(1) + 3 * h)
        error("Zbyt duży krok algorytmu, metoda nieskuteczna");
    end
    % [~, y(1:4, :)] = RK4klasyczna(f, y0, [a(1), a(1) + 3*h], h, eps);
    y(1, :) = y0;
    for i = 1:3 
        k(1, :) = f(x(i), y(i, :));
        k(2, :) = f(x(i) + 0.5 * h, y(i, :) + 0.5 * h * k(1, :));
        k(3, :) = f(x(i) + 0.5 * h, y(i, :) + 0.5 * h * k(2, :));
        k(4, :) = f(x(i) + h, y(i, :) + h * k(3, :));
        
        y(i + 1, :) = y(i, :) + (1 / 6) * h * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));        
    end
    
    % Predyktor - Korektor
    for i = 5:length(x)
        % predykcja i ewaluacja
        tmp = zeros(1, n);
        for j = 1:4
            tmp = tmp + betap(j) * f(x(i - j), y(i - j, :))';
        end
        yp = y(i - 1, :) + h * tmp;
        % korekcja i ewaluacja
        tmp = zeros(1, n);
        for j = 1:4
            tmp = tmp + betak(j + 1) * f(x(i - j), y(i - j, :))';
        end
        y(i, :) = y(i - 1, :) + h * (tmp + betak(1) * f(x(i), yp)');  
    end
end