% RK4zmienna.m
% Autor: Kamil Jabłonowski

function [t, x] = RK4zmienna(f, x0, a)
    
    % ustalenie potrzebnych parametrów
    
    
    %iteracja
    while (t(i) <= a(2))
        % wyznaczenie rozwiązania x(i+1) metodą RK
       
        % oszacowanie błędu
       
        % współczynnik korekty długości kroku alfa
        %korekta długości kroku
        hprop = s * alfa * h;
       
        if (s * alfa < 1)
            if (hprop < hmin)
              %nie da się znaleźć rozwiązania
            else
              % liczymy jeszcze raz z h = hprop
            end
        else
            % t(i+1) = t(i) + h
            % h = min(hprop, beta * h, a(2) - t(i))
            i = i + 1;
        end
       
    end
end