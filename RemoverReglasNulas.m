function[P] = RemoverReglasNulas(P, limites)

    [CantRows, CantCols] = size(P);

    % chequear si hay reglas nulas
    indices = all(P == 0, 2);
    [reglas indices_reglas] = find(indices > 0);

    % si hay reglas nulas
    for index=1:length(indices_reglas)
        %busco una variable de la regla al azar
        indice_valor = round((CantCols-1)*rand()) + 1;
        %busco un valor al azar
        valor = round((limites(indice_valor, 2)-1)*rand()) + 1;
        %le asigno ese valor a la regla para que deje ser nula
        P(reglas(index), indice_valor) = valor; 
    end
end