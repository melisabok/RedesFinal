function nada = Dibujar(Pop, limites, paso, NroFunc);

CantArgs = size(limites,2);

switch CantArgs
  case 1  % dibujo 2D
      hold off
      %Visualizar la funcion FUN en el intervalo indicado
      Intervalo = limites(1):paso:limites(2);

      y = FUN(NroFunc, Intervalo);
      plot(Intervalo,y);
      hold on
      % graficar los individuos
      
      Salida = FUN(NroFunc, [Pop.individuo]);
      plot([Pop.individuo],Salida,'*');
      pause(0.01);
      
  case 2 %dibujo 3D
      
      %== AGREGAR ACA EL DIBUJO ==

      
end      