function Pop = EvaluarFitness(Datos, Clase, numclase, Pop)

% evaluar el fitness de todos los individuos
popsize = length(Pop);

for j=1:popsize
    [soporte, confianza, fitness] = calcular_fitness( Datos, Pop(j).individuo, Clase, numclase);
    Pop(j).fitIndividuo = fitness;
    Pop(j).fitness = mean(fitness);

end
   
end