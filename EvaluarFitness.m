function Pop = EvaluarFitness(cmax, NroFunc, Pop)

% evaluar el fitness de todos los individuos
popsize = length(Pop);
Salida = FUN(NroFunc, [Pop.individuo]);
Fitness = abs(cmax * ones(1,popsize) - Salida);

for i=1:popsize
    Pop(i).fitness = Fitness(i);
end    