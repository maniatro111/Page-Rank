function [x] = SST(A, b)
    [latime lungime] = size(A);
    n = min(latime, lungime);
    x = zeros(n, n);
    %rezolvare pentru fiecare coloana a matricei inverse
    for k = 1:n

        for i = n:-1:1
            s = 0;
            %calculam suma produselor fiecarui element de pe linia i
            %cu valoarea corespunzatoare din matricea inversa
            %(elementul de pe diagonala principala se exclude
            for j = i + 1:n
                s+= A(i, j) * x(j, k);
            endfor

            %calcularea elementului Xik din inversa matricei
            x(i, k) = (b(i, k) - s) / A(i, i);
        endfor

    endfor

end
