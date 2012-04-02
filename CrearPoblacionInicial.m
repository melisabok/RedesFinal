function p = CrearPoblacionInicial(popsize, indsize, limites, limVELOC)
% genera un vector de popsize inidividuos aleatorios
% cada uno es una estructura con los valores necesarios

p = [];
[variables, col] = size(limites);
nuevo = zeros(indsize, variables);
veloc = zeros(indsize, variables);


for i=1:popsize
    for k=1:indsize
        for j=1:variables
            prob = rand();
            if (prob <= 0.2)
                nuevo(k,j) = round(rand*(limites(j,2)-limites(j,1))+limites(j,1));
            else
                nuevo(k,j) = 0;
            end
            veloc(k,j) = rand*(limVELOC(2)-limVELOC(1))+limVELOC(1);
        end
    end
    
    %antes valido que no haya creado una regla nula
    nuevo = RemoverReglasNulas(nuevo, limites);
    
    p = [p struct('individuo', nuevo, 'velocidad', veloc, 'pBest', nuevo, 'fitness',0,'fitpBest',0)];
end
end

