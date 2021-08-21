function R = Iterative(nume, d, eps)
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
    %initializarea vectorului anterior
    v = ones(n, 1) * inf;
    %initializarea primei iteratii a vectorului de PageRank
    cv = zeros(n, 1);
    cv(:) = 1 / n;
    %repetarea calcularii vectorului de rank-uri pana cand
    %eroarea dintre ele este mai mica decat epsilor
    while norm(cv - v) >= eps
        v = cv;
        cv = Mat_caciula * d * v + (1 - d) / n * ones(n, 1);
    endwhile

    R = v;
    fclose(file);
endfunction
