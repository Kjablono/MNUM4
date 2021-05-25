% prezentacja.m
% Autor: Kamil Jabłonowski
% funkcja uruchamiająca odpowiednie algorytmy oraz prezentująca wyniki w
% postaci wykresów, mierząca czas wykonania solwera oraz liczbę wykonanych
% iteracji, umożliwia porównanie rozwiązania z rozwiązaniem uzyskanym przy
% wykorzystaniu MATLABowej funkcji ode45 oraz zapisanie wykresów do plików
%
% zmienne wejściowe:
% solver - uchwyt do funkcji implementującej algorytm rozwiązania 
% f - uchwyt do funkcji wyznaczającej wartości prawych stron układu równań
% a = [x0, xk] - przedział na którym poszukujemy rozwiązania
%   x0 - początek przedziału
%   xk - koniec przedizału
% y0 - wektor warunków brzegowych [y00(x0), y01(x0),.. y0n(x0)]
% eps = [eps_względny, eps_bezwzględny] - wartości współczynników epsilon
%   potrzybnych przy wyznaczaniu błędu w metodach ze zmiennym krokiem
% zmienne globalne:
% save - zmienna ustawiona na wartość true powoduje zapisanie wykresów w
%   folderze ./plots
% comp_with_ode45 - zmienna ustawiona na wartość true porównuje porównanie
%   z funkcją MATLABową ode45
%
% zmienne wyjściowe:
% x - wektor wartości x w których wyznaczone zostały przybliżenia zmiennych
%   układu równań różniczkowych
% y - macierz wartości y, kolejne wiersze odpowiadają kolejnym chwilom
%   czasu x, kolumny odpowiadają kolejnym zmiennym y1, y2,.. ,yn

function [x, y] = prezentacja(solver, f, a, h, y0, eps)
    global save;
    global comp_with_ode45;
    % wypisanie informacji o zadaniu
    solver_name = func2str(solver);                 % nazwa metody jako nazwa funkcji
    constraints_str = '[';                          % warunki brzegowe w postaci znakowej w konwencji [y01_y02_..._y0n]
    fprintf("Rozwiązanie dla metody %s w przedziale [%d, %d]\nkrok = %f\nwarunki brzegowe\n", solver_name, a(1), a(2), h);
    for i = 1:length(y0)
        fprintf("y%d(%d) = %f\n", i, a(1), y0(i));
        if (i ~= 1)
            constraints_str = strcat(constraints_str, '_');
        end
        constraints_str = strcat(constraints_str,  num2str(y0(i)));
    end
    
    constraints_str = strcat(constraints_str, ']');
    
    % rozwiązanie z użyciem wybranego solvera
    tic;
    [x, y] = solver(f, y0, a, h, eps);
    t_solver = toc;
    fprintf("Czas obliczeń dla metody %s wyniósł %fms, wykonano %d iteracji\n", solver_name, t_solver * 1000, length(x));
    
    % rozwiązanie z użyciem wbudowanej funkcji ode45
    if (comp_with_ode45 == true)
        tic;
        [xref, yref] = ode45(f, a, y0);
        t_ode45 = toc;
        fprintf("Czas obliczeń dla metody ode45 wyniósł %fms, wykonano %d iteracji\n", t_ode45 * 1000, length(xref));
    end
    
    % prezentacja wyników  
    % rysowanie wykresów yi(x)
    for i = 1:size(y, 2)
        figure(i);
        clf(i)
        hold on;
        plot(x, y(:, i), 'r', 'DisplayName', solver_name);
        
        if (comp_with_ode45 == true)
            plot(xref, yref(:, i), 'b', 'DisplayName', 'ode45');
        end
        
        legend('Location', 'southeast');
        title(strcat(solver_name, ' y', num2str(i), '(x)'));
        hold off;
        
        if (save == true)
            saveas(i, strcat('./plots/', solver_name, '_y0=', constraints_str, '_h=', num2str(h), '_y', num2str(i), '(x).png'));
        end
    end
    
    % rysowanie wykresu w przestrzeni (y1, y2) w przypadku gdy problem
    % jest dwuwymiarowy
    if (size(y, 2) == 2)
        figure(3);
        clf(3);
        hold on;
        plot(y(:, 1), y(:, 2), 'r', 'DisplayName', solver_name);
        if (comp_with_ode45 == true)
            plot(yref(:, 1), yref(:, 2), 'b', 'DisplayName', 'ode45');
        end
        legend('Location', 'southeast');
        title(strcat(solver_name, ' (y1, y2)'));
        hold off;
        
        if (save == true)
            saveas(3, strcat('./plots/', solver_name, '_y0=', constraints_str, '_h=', num2str(h), '_y1(y2).png'));
        end
    end
    
    
    if (size(y, 2) == 3)
        figure(4);
        clf(4);
        hold on;
        plot3(y(:, 1), y(:, 2), y(:, 3), 'r', 'DisplayName', solver_name);
        if (comp_with_ode45 == true)
            plot3(yref(:, 1), yref(:, 2), yref(:, 3), 'b', 'DisplayName', 'ode45');
        end
        legend('Location', 'southeast');
        title(strcat(solver_name, '(y1, y2, y3)'));
        hold off;
        view(3);
        
        if (save == true)
            saveas(4, strcat('./plots/', solver_name, '_y0=', constraints_str, '_h=', num2str(h), '_y1(y2, y3).png'));
        end       
    end   
end