% func.m
% Autor: Kamil Jabłonowski


function [y] = func(~, x)
    y = zeros(2, size(x, 1));
    
    if (size(x, 2) ~= 2) 
        error("zły rozmiar wektora wejściowego do funkcji func");
    end
    
    y(1, :) = x(2) + x(1).* (0.2 - x(:, 1).^2 - x(:, 2).^2);
    y(2, :) = - x(:, 1) + x(:, 2).* (0.2 - x(:, 1).^2 - x(:, 2).^2);
end