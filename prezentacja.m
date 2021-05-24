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
% a = [t0, tk] - przedział na którym poszukujemy rozwiązania
%   t0 - początek przedziału
%   tk - koniec przedizału
% x0 - wektor warunków brzegowych [x00(t0), x01(t0),.. x0n(t0)]
% eps = [eps_względny, eps_bezwzględny] - wartości współczynników epsilon
%   potrzybnych przy wyznaczaniu błędu w metodach ze zmiennym krokiem
% zmienne globalne:
% save - zmienna ustawiona na wartość true powoduje zapisanie wykresów w
%   folderze ./plots
% comp_with_ode45 - zmienna ustawiona na wartość true porównuje porównanie
%   z funkcją MATLABową ode45
%
% zmienne wyjściowe:
% t - wektor wartości t w których wyznaczone zostały przybliżenia zmiennych
%   układu równań różniczkowych
% x - macierz wartości x, kolejne wiersze odpowiadają kolejnym chwilom
%   czasu t, kolumny odpowiadają kolejnym zmiennym x1, x2,.. ,xn

function [t, x] = prezentacja(solver, f, a, h, x0, eps)
    global save;
    global comp_with_ode45;
    % wypisanie informacji o zadaniu
    solver_name = func2str(solver);                 % nazwa metody jako nazwa funkcji
    constraints_str = '[';                          % warunki brzegowe w postaci znakowej w konwencji [x01_x02_..._x0n]
    fprintf("Rozwiązanie dla metody %s w przedziale [%d, %d]\nkrok = %f\nwarunki brzegowe\n", solver_name, a(1), a(2), h);
    for i = 1:length(x0)
        fprintf("x%d(%d) = %f\n", i, a(1), x0(i));
        if (i ~= 1)
            constraints_str = strcat(constraints_str, '_');
        end
        constraints_str = strcat(constraints_str,  num2str(x0(i)));
    end
    
    constraints_str = strcat(constraints_str, ']');
    
    % rozwiązanie z użyciem wybranego solvera
    tic;
    [t, x] = solver(f, x0, a, h, eps);
    t_solver = toc;
    fprintf("Czas obliczeń dla metody %s wyniósł %fms, wykonano %d iteracji\n", solver_name, t_solver * 1000, length(t));
    
    % rozwiązanie z użyciem wbudowanej funkcji ode45
    if (comp_with_ode45 == true)
        tic;
        [tref, xref] = ode45(f, a, x0);
        t_ode45 = toc;
        fprintf("Czas obliczeń dla metody ode45 wyniósł %fms, wykonano %d iteracji\n", t_ode45 * 1000, length(tref));
    end
    
    % prezentacja wyników  
    % rysowanie wykresów xi(t)
    for i = 1:size(x, 2)
        figure(i);
        clf(i)
        hold on;
        plot(t, x(:, i), 'r', 'DisplayName', solver_name);
        
        if (comp_with_ode45 == true)
            plot(tref, xref(:, i), 'b', 'DisplayName', 'ode45');
        end
        
        legend('Location', 'southeast');
        title(strcat(solver_name, ' x', num2str(i), '(t)'));
        hold off;
        
        if (save == true)
            saveas(i, strcat('./plots/', solver_name, '_x0=', constraints_str, '_h=', num2str(h), '_x', num2str(i), '(t).png'));
        end
    end
    
    % rysowanie wykresu w przestrzeni (x1, x2) w przypadku gdy problem
    % jest dwuwymiarowy
    if (size(x, 2) == 2)
        figure(3);
        clf(3);
        hold on;
        plot(x(:, 1), x(:, 2), 'r', 'DisplayName', solver_name);
        if (comp_with_ode45 == true)
            plot(xref(:, 1), xref(:, 2), 'b', 'DisplayName', 'ode45');
        end
        legend('Location', 'southeast');
        title(strcat(solver_name, ' (x1, x2)'));
        hold off;
        
        if (save == true)
            saveas(3, strcat('./plots/', solver_name, '_x0=', constraints_str, '_h=', num2str(h), '_x1(x2).png'));
        end
    end
    
    
    if (size(x, 2) == 3)
        figure(4);
        clf(4);
        hold on;
        plot3(x(:, 1), x(:, 2), x(:, 3), 'r', 'DisplayName', solver_name);
        if (comp_with_ode45 == true)
            plot3(xref(:, 1), xref(:, 2), xref(:, 3), 'b', 'DisplayName', 'ode45');
        end
        legend('Location', 'southeast');
        title(strcat(solver_name, '(x1, x2, x3)'));
        hold off;
        view(3);
        
        if (save == true)
            saveas(4, strcat('./plots/', solver_name, '_x0=', constraints_str, '_h=', num2str(h), '_x1(x2, x3).png'));
        end       
    end   
end