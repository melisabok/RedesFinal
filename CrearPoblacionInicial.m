function p = CrearPoblacionInicial(popsize, limites, limVELOC)
% genera un vector de popsize inidividuos aleatorios
% cada uno es una estructura con los valores necesarios

p = [];
nuevo = [0,0,0];

[variables, col] = size(limites);

for i=1:popsize
    for j=1:variables
        nuevo(j) = round(rand*(limites(j,2)-limites(j,1))+limites(j,1));
    end
    veloc = rand*(limVELOC(2)-limVELOC(1))+limVELOC(1);

    p = [p struct('individuo', nuevo, 'velocidad', veloc, 'pBest', nuevo, 'fitness',0,'fitpBest',0)];
end

