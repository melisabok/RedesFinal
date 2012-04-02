function Pop = EvaluarFitnessPoblacion(Datos, Clase, numclase, Pop)

% evaluar el fitness de todos los individuos
popsize = length(Pop);

for j=1:popsize
    indsize = size(Pop(j).individuo, 1);
    [soporte, confianza, fitness] = calcular_fitness( Datos, Pop(j).individuo, Clase, numclase);
    Pop(j).fitness = (fitness / indsize);

end
   