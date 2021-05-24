% func.m
% Autor: Kamil Jabłonowski
% funkcja wyznaczająca wartości prawych stron równań układu równań danego w
% w treści zadania
%
% zmienne wejściowe
% x - wektor wartości funkcji x(t)
% ~ - stworzone solvery umożliwiają wykorzystanie dla równań, w których po
%   prawej stronie występuje jawnie zmienna t, w tej funkcji t nie
%   występuje jawnie, więc nie wykorzystano tej możliwości
%
% zmienne wyjściowe
% y - kolumnowy wektor wartości prawych stron równań, kolejne wiersze 
%   odpowiadają kolejnym równaniom (kolumnowy ze względu na fakt, 
%   że wymaga tego wbudowana funkcja ode45, służąca za funkcję referencyjną
%   dla badanych solverów) 


function [y] = func(~, x)
    y = zeros(2, 1);
    
    if (length(x) ~= 2) 
        error("zły rozmiar wektora wejściowego do funkcji func");
    end
    
    y(1) = x(2) + x(1) * (0.2 - x(1)^2 - x(2)^2);
    y(2) = - x(1) + x(2) * (0.2 - x(1)^2 - x(2)^2);
end