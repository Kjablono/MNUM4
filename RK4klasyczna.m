% RK4klasyczna.m
% Autor: Kamil Jabłonowski
% funkcja wyznacza rozwiązanie układu równań różniczkowych o dowolnej
% wymiarowości metodą Rungego-Kutty 4 rzędu ze stałym krokiem (RK4)
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



function [x, y] = RK4klasyczna(f, y0, a, h, ~)
    n = length(y0);             % wymiarowość układu
    x = (a(1):h:a(2))';         % chwile czasu w których wyznaczane będą wartości
    k = zeros(4, n);            % macierz na wartości k używane w metodzie
    y = zeros(length(x), n);    % macierz na rozwiązania y(i,j) - wartość j-tej funkcji dla xi
    y(1, :) = y0;
    for i = 1:(length(x) - 1) 
        k(1, :) = f(x(i), y(i, :));
        k(2, :) = f(x(i) + 0.5 * h, y(i, :) + 0.5 * h * k(1, :));
        k(3, :) = f(x(i) + 0.5 * h, y(i, :) + 0.5 * h * k(2, :));
        k(4, :) = f(x(i) + h, y(i, :) + h * k(3, :));
        
        y(i + 1, :) = y(i, :) + (1 / 6) * h * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));        
    end
end