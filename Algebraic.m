function R = Algebraic(nume, d)
    %deschiderea fisierului
    file = fopen(nume);
    %citirea numarului de pagini
    n = fscanf(file,  '%d\n', 1);
    %initializarea matricei de adiacenta
    mat = zeros(n, n);
    %initializarea matricei diagonale cu inversul
    %valorii numarului de pagini de pe o pagina
    K = zeros(n, n);
    %citesc n linii ce reprezinta paginile ale caror link-uri
    %sunt pe o pagina p

    for i = 1:n
        %citirea indicelui site-ului
        dump=fscanf(file,'%d',1);
        %citirea numarului de pagini
        nrval=fscanf(file,'%d',1);
        %citirea indicilor paginilor vecine
        vecini=fscanf(file,'%d',nrval);
        %marcarea vecinilor
        mat(i, vecini(1:nrval)) = 1;
    endfor

    for i = 1:n
        %corectarea aparitiilor e 1 pe coloana principala
        mat(i, i) = 0;
        %calcularea matricei diagonale
        K(i, i) = 1 / sum(mat(i, :));
    endfor

    %calcularea matricei de rotatie
    Mat_caciula = (K * mat)';
    %calcularea inversei maticei In - d*mat_caciula
    N = PR_Inv(eye(n) - d * Mat_caciula);
    %calcularea vectorului de rank-uri
    R = N * (1 - d) / n * ones(n, 1);
    %inchiderea fisierului
    fclose(file);
endfunction
