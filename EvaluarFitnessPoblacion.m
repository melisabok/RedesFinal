function Pop = EvaluarFitnessPoblacion(Datos, Clase, numclase, Pop)

% evaluar el fitness de todos los individuos
popsize = length(Pop);
[CantDatos, CantCols] = size(Datos);
indsize = 2;

for j=1:popsize
    fitness = 0;
    for h=1:indsize
        antecedente = 0;
        correctos = 0;
        for i=1:CantDatos
            esIgual = 1;
            k = 1;
            Regla = Pop(j).individuo(h,:); 
            while esIgual && k <= CantCols
                if (Regla(k) > 0) && (Regla(k) ~= Datos(i,k))
                    esIgual = 0;
                end
                k = k + 1;
            end
            if (esIgual == 1)
                antecedente = antecedente + 1;
                correctos = correctos + (Clase(i) == numclase);
            end
        end
        confianza = correctos ./ antecedente;
        confianza(isnan(confianza))=0;  
        soporte = correctos ./ CantDatos;
        fitness = fitness + (soporte + confianza) ./ (2);
    end
    Pop(j).fitness = (fitness / indsize);

end
   