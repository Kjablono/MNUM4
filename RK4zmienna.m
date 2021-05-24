% RK4zmienna.m
% Autor: Kamil Jabłonowski

function [t, x] = RK4zmienna(f, x0, a, h, eps)
    
    t = zeros(2, 1);
    t(1) = a(1);
    x(1, :) = x0;
    s = 0.9;
    i = 1;
    beta = 1.5;
    hmin = 10e-12;
    
    %iteracja
    while (t(i) <= a(2))
        % wyznaczenie rozwiązania x(i+1) metodą RK
        % [~, [~; x1]] = RK4klasyczna(f, x(i, :), [t(i), t(i) + h], h, eps);
        k(1, :) = f(t(i), x(i, :));
        k(2, :) = f(t(i) + 0.5 * h, x(i, :) + 0.5 * h * k(1, :));
        k(3, :) = f(t(i) + 0.5 * h, x(i, :) + 0.5 * h * k(2, :));
        k(4, :) = f(t(i) + h, x(i, :) + h * k(3, :));
        
        x1 = x(i, :) + (1 / 6) * h * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));
        
        % wyznaczenie rozwiązania wg zasady podwójnego kroku
        % [~, [~; ~; x(i + 1,:)]] = RK4klasyczna(f, x(i, :), [t(i), t(i) + h], h / 2, eps);
        % 1 krok
        k(1, :) = f(t(i), x(i, :));
        k(2, :) = f(t(i) + 0.5 * (h / 2), x(i, :) + 0.5 * (h / 2) * k(1, :));
        k(3, :) = f(t(i) + 0.5 * (h / 2), x(i, :) + 0.5 * (h / 2) * k(2, :));
        k(4, :) = f(t(i) + h / 2, x(i, :) + (h / 2) * k(3, :));
            
        tmp_x = x(i, :) + (1 / 6) * (h / 2) * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));
        
        % 2 krok
        tmp_t = t(i) + h / 2;
        k(1, :) = f(tmp_t, tmp_x);
        k(2, :) = f(tmp_t + 0.5 * (h / 2), tmp_x + 0.5 * (h / 2) * k(1, :));
        k(3, :) = f(tmp_t + 0.5 * (h / 2), tmp_x + 0.5 * (h / 2) * k(2, :));
        k(4, :) = f(tmp_t + h / 2, tmp_x + (h / 2) * k(3, :));
        
        x(i + 1, :) = tmp_x + (1 / 6) * (h / 2) * (k(1, :) + 2 * k(2, :) + 2 * k(3, :) + k(4, :));
        
        % oszacowanie błędu
        delta = (x(i + 1, :) - x1) / 15;        % 15 == 2^p - 1, p - rząd metody
        epse = abs(x(i + 1, :)) * eps(1) + eps(2);
        
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
            t(i + 1) = t(i) + h;
            h = min([hprop, beta * h, a(2) - t(i)]);
            i = i + 1;
        end
    end
end