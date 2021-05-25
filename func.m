% func.m
% Autor: Kamil Jabłonowski
% funkcja wyznaczająca wartości prawych stron równań układu równań danego w
% w treści zadania
%
% zmienne wejściowe
% y - wektor wartości funkcji y(x)
% ~ - stworzone solvery umożliwiają wykorzystanie dla równań, w których po
%   prawej stronie występuje jawnie zmienna x, w tej funkcji x nie
%   występuje jawnie, więc nie wykorzystano tej możliwości
%
% zmienne wyjściowe
% yp - kolumnowy wektor wartości prawych stron równań, kolejne wiersze 
%   odpowiadają kolejnym równaniom (kolumnowy ze względu na fakt, 
%   że wymaga tego wbudowana funkcja ode45, służąca za funkcję referencyjną
%   dla badanych solverów) 


function [yp] = func(~, y)
    yp = zeros(2, 1);
    
    if (length(y) ~= 2) 
        error("zły rozmiar wektora wejściowego do funkcji func");
    end
    
    yp(1) = y(2) + y(1) * (0.2 - y(1)^2 - y(2)^2);
    yp(2) = - y(1) + y(2) * (0.2 - y(1)^2 - y(2)^2);
end