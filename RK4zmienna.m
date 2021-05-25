% RK4zmienna.m
% Autor: Kamil Jabłonowski
% funkcja wyznacza rozwiązanie układu równań różniczkowych o dowolnej
% wymiarowości metodą Rungego-Kutty czwartego rzędu ze zmiennym krokiem.
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
% h - krok początkowy
% eps = [eps_względny, eps_bezwzględny] - wartości współczynników epsilon
%   potrzybnych przy wyznaczaniu błędu
%
% zmienne wyjściowe:
% x - wektor wartości x w których wyznaczone zostały przybliżenia zmiennych
% układu równań różniczkowych
% y - macierz wartości y, kolejne wiersze odpowiadają kolejnym wartościom
% x, kolumny odpowiadają kolejnym zmiennym y1, y2,.. ,yn

function [x, y] = RK4zmienna(f, y0, a, h, eps)
    
    x = zeros(2, 1);
    x(1) = a(1);
    y(1, :) = y0;
    s = 0.9;
    i = 1;
    beta = 1.5;
    hmin = 10e-12;
    
    %iteracja
    while (x(i) <= a(2))
        % wyznaczenie rozwiązania y(i+1) metodą RK
%         [~, odp] = RK4klasyczna(f, y(i, :), [x(i), x(i) + h], h, eps);
%         y1 = odp(2, :);
        k(1, :) = f(x(i), y(i, :));
        k(2, :) = f(x(i) + 0.5 * h, y(i, :) + 0.5 * h * k(1, :));
        k(3, :) = f(x(i) + 0.5 * h, y(i, :) + 0.5 * h * k(2, :));
        k(4, :) = f(x(i) + h, y(i, :) + h * k(3, :));
        
        y1 = y(i, :) + (1 / 6) * h * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));
        
        % wyznaczenie rozwiązania wg zasady podwójnego kroku
%         [~, odp] = RK4klasyczna(f, y(i, :), [x(i), x(i) + h], h / 2, eps);
%         y(i + 1, :) = odp(3, :);
        % 1 krok
        k(1, :) = f(x(i), y(i, :));
        k(2, :) = f(x(i) + 0.5 * (h / 2), y(i, :) + 0.5 * (h / 2) * k(1, :));
        k(3, :) = f(x(i) + 0.5 * (h / 2), y(i, :) + 0.5 * (h / 2) * k(2, :));
        k(4, :) = f(x(i) + h / 2, y(i, :) + (h / 2) * k(3, :));
            
        tmp_y = y(i, :) + (1 / 6) * (h / 2) * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));
        
        % 2 krok
        tmp_t = x(i) + h / 2;
        k(1, :) = f(tmp_t, tmp_y);
        k(2, :) = f(tmp_t + 0.5 * (h / 2), tmp_y + 0.5 * (h / 2) * k(1, :));
        k(3, :) = f(tmp_t + 0.5 * (h / 2), tmp_y + 0.5 * (h / 2) * k(2, :));
        k(4, :) = f(tmp_t + h / 2, tmp_y + (h / 2) * k(3, :));
        
        y(i + 1, :) = tmp_y + (1 / 6) * (h / 2) * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));
        
        % oszacowanie błędu
        delta = (y(i + 1, :) - y1) / 15;        % 15 == 2^p - 1, p - rząd metody
        epse = abs(y(i + 1, :)) * eps(1) + eps(2);
        
        % współczynnik korekty długości kroku alfa
        alfa = min(epse / abs(delta))^(1 / 5);       % 1 / 5 == 1 / (p + 1), p - rząd metody
        
        %korekta długości kroku
        hprop = s * alfa * h;
       
        if (s * alfa < 1) % poprawka
            if (hprop < hmin)
                error("Nie da się znaleźć rozwiązania z podaną dokładnością, wybierz mniejsze wartości eps");
            else
                h = hprop;
            end
        else %kolejny punkt
            x(i + 1) = x(i) + h;
            h = min([hprop, beta * h, a(2) - x(i)]);
            i = i + 1;
        end
    end
end