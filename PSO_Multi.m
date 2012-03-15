clear
clc

Datos = [2,2,2,1;
2,1,2,0;
3,2,2,1;
1,2,2,1;
1,2,1,0;
1,1,1,0;
3,1,1,1;
2,1,1,0;
2,2,1,1;
1,1,1,0;
2,2,1,1;
3,2,2,1;
1,1,1,0;
1,2,2,1];

[CantRows, CantCols] = size(Datos);

popsize = 3;   % tamanio de la poblacion
indsize = 2;   % tamanio del individuo, cantidad de reglas en la solucion
elitismo = 0;  % el mejor NO se mueve

MAX_ITERA = 500;

alfa1 = 0.5;
alfa2 = 0.5;

%== Factor de inercia inicial y final
W = [1.5; 0.2];

limVELOC = [-0.5; 0.5];  %== intervalo en el que puede variar la velocidad ==

%[cmax, limites, paso, NroFunc] = ElegirFuncion;
limites = [0, 3;
           0, 2;
           0, 2];
       
Pop = CrearPoblacionInicial(popsize, indsize, limites, limVELOC);

itera = 0;
fitgBest = 0;
igualMejor = 0;
gBest = zeros(indsize, 3);

Pop = EvaluarFitness(Datos(:,1:3), Datos(:,4), 1, Pop);

Pop
 
while (itera < MAX_ITERA) & (igualMejor < 0.1 * MAX_ITERA)

      for i=1:popsize
         if sum(Pop(i).fitness) > sum(Pop(i).fitpBest)
             Pop(i).pBest = Pop(i).individuo;
             Pop(i).fitpBest = Pop(i).fitness;
         end
         if sum(Pop(i).fitness) > sum(fitgBest)
             gBest = Pop(i).individuo;
             fitgBest = Pop(i).fitness;
         end
     end    
     
     %mover todos los individuos
     %==========================
     % recordar quien es el mejor y donde esta
     [FitMaxAnt, quienAnt] = max([Pop.fitness]);
     popindex = round(quienAnt / indsize);
     indindex = mod(quienAnt, indsize);
     if(indindex == 0)
         indindex = indsize;
     end
     
     popindex
     indindex
     MejorIndividuo = Pop(popindex).individuo(indindex,:);
     
     MejorIndividuo
     igualMejor
     %== las particulas cada vez se mueven menos ===
     w_inercia = W(1) - ( W(1) - W(2) ) * (itera / MAX_ITERA);
 
     
     for i=1:popsize
         Pop(i).velocidad = w_inercia * Pop(i).velocidad + alfa1*rand*(Pop(i).pBest-Pop(i).individuo) + alfa2*rand*(gBest-Pop(i).individuo);
         for k=1:indsize
             for j=1:3
                 %verificar que la velocidad no se vaya de rango
                 Pop(i).velocidad(k,j) = max( limVELOC(1), Pop(i).velocidad(k,j) );
                 Pop(i).velocidad(k,j) = min( limVELOC(2), Pop(i).velocidad(k,j) );

                 Pop(i).individuo(k,j) = round(Pop(i).individuo(k,j) + Pop(i).velocidad(k,j));

                 %validar que el individuo no se vaya de los limites permitidos
                 Pop(i).individuo(k,j) = max( limites(j, 1), Pop(i).individuo(k,j) );
                 Pop(i).individuo(k,j) = min( limites(j, 2), Pop(i).individuo(k,j) );
             end
         end
         velocidad = Pop(i).velocidad;
         individuo = Pop(i).individuo;
         velocidad
         individuo
     end
     
     Pop = EvaluarFitness(Datos(:,1:3), Datos(:,4), 1, Pop);
     [FitMax, quien] = max([Pop.fitness]);
     if (elitismo==1)  & (FitMax < FitMaxAnt)
         % el mejor se movio y empeoro. Hay que recuperarlo y ponerlo donde estaba
         Pop(quienAnt) = MejorIndividuo;
         quien = quienAnt;
         FitMax = FitMaxAnt;
     end    
         
     if FitMaxAnt == FitMax
         igualMejor = igualMejor + 1;
     else
         igualMejor = 1;
     end    
 
     itera = itera + 1;
     
end

% disp(sprintf('\nIteraciones realizadas = %d',itera));
% disp(sprintf('Mejor Individuo = %f',Pop(quien).individuo));
% disp(sprintf('Aptitud del mejor individuo : %f',Pop(quien).fitness));
% disp(sprintf('Velocidad del mejor individuo : %f',Pop(quien).velocidad));
% disp(sprintf('Ultimo valor de inercia utilizado : %f',w_inercia));
% 
% disp(sprintf('El mejor individuo no ha sido superado en las ultimas %d iteraciones',igualMejor));
% 
