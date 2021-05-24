function [y] = mockfun(t, x)
    y = zeros(3, 1);
    if (length(x) ~= 3) 
        error("zły rozmiar wektora wejściowego do funkcji func");
    end
    
    y(1) = x(2) + x(1) * (0.2 - x(1)^2 - x(2)^2);
    y(2) = - x(1) + x(2) * (0.2 - x(1)^2 - x(2)^2);
    y(3) = - x(3) + t * x(2);
end