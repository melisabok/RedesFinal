function[R] = PSO_Multi(Datos, Clase, CantReglas, popsize, elitismo) 

    [CantRows, CantCols] = size(Datos);

    %Matriz de datos, sin la clase
    X = Datos(:,1:CantCols - 1);
    %Vector de clase
    Z = Datos(:,CantCols);
    %Cantidad de variables
    variables = CantCols - 1;
    %Cantidad de reglas que quiero obtener, tamanio del individuo
    indsize = CantReglas;

    %Parametros del PSO
    MAX_ITERA = 500;
    alfa1 = 0.5;
    alfa2 = 0.5;
    %== Factor de inercia inicial y final
    W = [1.5; 0.2];
    %== intervalo en el que puede variar la velocidad ==
    limVELOC = [-0.5; 0.5];  
    % Armo los limites de cada variable. 
    limites = [zeros(variables,1) max(Datos(:,1:variables))'];


    Pop = CrearPoblacionInicial(popsize, indsize, limites, limVELOC);

    itera = 0;
    fitgBest = 0;
    gBest = 0;
    igualMejor = 0;

    Pop = EvaluarFitness(X, Z, Clase, Pop);

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
         MejorIndividuo = Pop(quienAnt);

         %== las particulas cada vez se mueven menos ===
         w_inercia = W(1) - ( W(1) - W(2) ) * (itera / MAX_ITERA);


         for i=1:popsize
                
             Pop(i).velocidad = w_inercia * Pop(i).velocidad + alfa1*rand*(Pop(i).pBest-Pop(i).individuo) + alfa2*rand*(gBest-Pop(i).individuo);
                    
             %verificar que la velocidad no se vaya de rango
             Pop(i).velocidad = max( limVELOC(1), Pop(i).velocidad );
             Pop(i).velocidad = min( limVELOC(2), Pop(i).velocidad );

             Pop(i).individuo = round(Pop(i).individuo + Pop(i).velocidad );

             %validar que el individuo no se vaya de los limites permitidos
             %para todas las dimensiones que tiene el registro
             Pop(i).individuo = ValidarReglas(Pop(i).individuo, limites);

         end

         Pop = EvaluarFitness(X, Z, 1, Pop);
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

    disp(sprintf('\nIteraciones realizadas = %d',itera));
    disp(sprintf('\nMejor Individuo :'));
    disp(Pop(quien).individuo);
    disp(sprintf('\nAptitud del mejor individuo : %f',Pop(quien).fitness));
    disp(sprintf('\nVelocidad del mejor individuo :'));
    disp(Pop(quien).velocidad);
    disp(sprintf('\nUltimo valor de inercia utilizado : %f',w_inercia));
    disp(sprintf('\nEl mejor individuo no ha sido superado en las ultimas %d iteraciones',igualMejor));

end