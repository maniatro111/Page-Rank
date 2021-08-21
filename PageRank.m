function [R1 R2] = PageRank(nume, d, eps)
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
    
    %citirea enter-ului din buffer
    %de dupa citirea intregii liste de vecini
    dump=fgets(file);
    %citirea si convertirea in numar a lui val1 si val2
    val1 = str2num(fgets(file));
    val2 = str2num(fgets(file));
    %calcularea vectorului de rank-uri prin metoda Iterative
    R1 = Iterative(nume, d, eps);
    %calcularea vectorului de rank-uri prin metoda Algebraic
    R2 = Algebraic(nume, d);
    %calcularea clasamentului
    v = Apartenenta(R2, val1, val2);
    %crearea numelui fisierului de output
    out = strcat(nume, ".out");
    %deschiderea fisierului de output
    file2 = fopen(out, "w");
    %scrie numarul de pagini
    fprintf(file2, '%g\n\n', n);
    %scie vectorul calculat prin metoda Iterative
    fprintf(file2, '%f\n', R1);
    fprintf(file2, '\n');
    %scie vectorul calculat prin metoda Algebraic
    fprintf(file2, '%f\n', R2);
    fprintf(file2, '\n');
    %scrie vectorul clasamentului
    for i = 1:n
        fprintf(file2, '%g %g %f\n', i, v(i, 1), v(i, 2));
    endfor

    %inchiderea fisierului de input
    fclose(file);
    %inchiderea fisierului de output
    fclose(file2);
endfunction
