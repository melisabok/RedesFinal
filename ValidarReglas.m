function[P] = ValidarReglas(P, limites)


    [CantRows, CantCols] = size(P);
    
    % chequear los limites
    for i=1:CantRows
        for j=1:CantCols
            P(i, j) = max( limites(j, 1), P(i, j));
            P(i, j) = min( limites(j, 2), P(i, j));
        end
    end

    % chequear si hay reglas nulas
    P = RemoverReglasNulas(P, limites);
end