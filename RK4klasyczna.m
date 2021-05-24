% RK4klasyczna.m
% Autor: Kamil Jabłonowski
% funkcja wyznacza rozwiązanie układu równań różniczkowych o dowolnej
% wymiarowości metodą Rungego-Kutty 4 rzędu ze stałym krokiem (RK4)
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



function [t, x] = RK4klasyczna(f, x0, a, h, ~)
    n = length(x0);             % wymiarowość układu
    t = (a(1):h:a(2))';         % chwile czasu w których wyznaczane będą wartości
    k = zeros(4, n);            % macierz na wartości k używane w metodzie
    x = zeros(length(t), n);    % macierz na rozwiązania x(i,j) - wartość j-tej funkcji w chwili i
    x(1, :) = x0;
    for i = 1:(length(t) - 1) 
        k(1, :) = f(t(i), x(i, :));
        k(2, :) = f(t(i) + 0.5 * h, x(i, :) + 0.5 * h * k(1, :));
        k(3, :) = f(t(i) + 0.5 * h, x(i, :) + 0.5 * h * k(2, :));
        k(4, :) = f(t(i) + h, x(i, :) + h * k(3, :));
        
        x(i + 1, :) = x(i, :) + (1 / 6) * h * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));        
    end
end