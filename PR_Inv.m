function B = PR_Inv(A)
    [m, n] = size(A);
    R = zeros(m, n);
    Q = eye(m);

    for i = 1:n
        %calcularea optimizata a elementelor Rji cu j inte 1 si i-1
        R(1:i - 1, i) = Q(1:m, 1:i - 1)' * A(1:m, i);
        %salvarea valorii Ai - suma r*q intr-o variabila auxiliara
        y = A(1:m, i) - Q(1:m, 1:i - 1) * R(1:i - 1, i);
        %calcularea lui Ri
        R(i, i) = norm(y);
        %calcularea elementelor din Q
        Q(1:m, i) = y ./ R(i, i);
    endfor

    %inmultirea cu Q^-1 pentru a calcula inversa
    X = eye(m) * Q';
    %calcularea inversei lui A
    B = SST(R, X);
endfunction
