clear
clc

datos = csvread('Vinos.csv');
[CantRows, CantCols] = size(datos);
P = escalar(datos, 2:Cols);

popsize = 30;
elitismo = 1;  % el mejor NO se mueve

MAX_ITERA = 500;

alfa1 = 0.5;
alfa2 = 0.5;

%== Factor de inercia inicial y final
W = [1.5; 0.2];

limVELOC =[ -0.5; 0.5];  %== intervalo en el que puede variar la velocidad ==

%[cmax, limites, paso, NroFunc] = ElegirFuncion;
             
Pop = CrearPoblacionInicial(popsize, limites, limVELOC);

Dibujar(Pop, limites, paso, NroFunc);

itera=0;
fitgBest = 0;

igualMejor = 0;
Pop = EvaluarFitness(cmax, NroFunc, Pop);

while (itera< MAX_ITERA) & (igualMejor < 0.1*MAX_ITERA)

    for i=1:popsize
        if Pop(i).fitness > Pop(i).fitpBest
            Pop(i).pBest = Pop(i).individuo;
            Pop(i).fitpBest = Pop(i).fitness;
        end
        if Pop(i).fitness > fitgBest
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
        
        Pop(i).individuo = Pop(i).individuo + Pop(i).velocidad;
        
        %validar que el individuo no se vaya de los limites permitidos
        Pop(i).individuo = max( limites(1), Pop(i).individuo );
        Pop(i).individuo = min( limites(2), Pop(i).individuo );
    end
    
    Pop = EvaluarFitness(cmax, NroFunc, Pop);
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

    Dibujar(Pop, limites,paso, NroFunc);
    itera = itera + 1;
    
end

disp(sprintf('\nIteraciones realizadas = %d',itera));
disp(sprintf('Mejor Individuo = %f',Pop(quien).individuo));
disp(sprintf('Aptitud del mejor individuo : %f',Pop(quien).fitness));
disp(sprintf('Velocidad del mejor individuo : %f',Pop(quien).velocidad));
disp(sprintf('Ultimo valor de inercia utilizado : %f',w_inercia));

disp(sprintf('El mejor individuo no ha sido superado en las ultimas %d iteraciones',igualMejor));

