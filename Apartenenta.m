function y = Apartenenta(x, val1, val2)
    %calcularea lui a
    a = 1 / (val2 - val1);
    %calcularea lui b
    b = -val1 / (val2 - val1);
    n = length(x);
    %crearea vecorului sortat ce va contine
    %si pozitiile initiale ale paginilor
    %prima coloana contine numarul site-ului si a doua
    %rank-urile corespunzatoare site-ulu
    y = zeros(n, 2);
    y(:, 1) = 1:n;
    %coierea rank-urilor
    y(:, 2) = x(:);
    %sortarea matricei dupa a doua coloana,
    %adica dupa valoarea rank-urilor
    y = sortrows(y, -2);
    %calcularea functiei F pentru fiecare site
    for i = 1:n

        if y(i, 2) < val1
            y(i, 2) = 0;
        else

            if y(i, 2) > val2
                y(i, 2) = 1;
            else
                y(i, 2) = a * y(i, 2) + b;
            endif

        endif

    endfor

endfunction
