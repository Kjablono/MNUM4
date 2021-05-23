% adams.m
% Autor: Kamil Jabłonowski


function [t, x] = PK4adams(f, x0, a, h)

    % wartości współczynników beta dla metody Adamsa 4 rzędu
    % dla predyktora (metoda Adamsa jawna)
    betap = [55/24, -59/24, 37/24, -9/24];
    % dla korektora (metoda Adamsa niejawna)
    betak = [251/720, 646/720, -264/720, 106/720, -19/720];
    
    n = length(x0);             % wymiarowość układu
    t = (a(1):h:a(2))';         % chwile czasu w których wyznaczane będą wartości
    x = zeros(length(t), n);    % macierz na rozwiązania x(i,j) - wartość j-tej funkcji w chwili i
    
    % wyznaczenie pierwszych czterech wartości algorytmem RK4klasyczna
    if (a(2) < a(1) + 4 * h)
        error("Zbyt duży krok algorytmu, metoda nieskuteczna");
    end
    [~, x(1:4, :)] = RK4klasyczna(f, x0, [a(1), a(1) + 3*h], h);
    
    % Predyktor - Korektor
    for i = 5:length(t)
        % predykcja i ewaluacja
        xp = x(i - 1, :) + h * betap * f(t(i-4:i-1), x(i-4:i-1, :))';
        % korekcja i ewaluacja
        x(i, :) = x(i - 1, :) + h * (betak(2:5) * f(t(i-4:i-1), x(i-4:i-1, :))' + betak(1) * f(t(i), xp))';        
    end
end