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
    indices = all(P == 0, 2);
    [reglas indices_reglas] = find(indices > 0);

    % si hay reglas nulas
    for index=1:length(indices_reglas)
        %busco una variable de la regla al azar
        indice_valor = round((CantRows-1)*rand()) + 1;
        %busco un valor al azar
        valor = round((limites(indice_valor, 2)-1)*rand()) + 1;
        %le asigno ese valor a la regla para que deje ser nula
        P(reglas(index), indice_valor) = valor; 
    end
end