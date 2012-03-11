function [cmax, limites, paso, valorElegido] = ElegirFuncion;

disp('--- FUNCIONES ---');
disp('1--> f(x) = x^2');
disp('2--> f(x) = ((-x) .* sin(10 * pi * x) )+ ones(1,length(x))');
disp('3--> f(x) = 0.5+((sin( sqrt(x.^2) ).^2-0.5)./(1+0.001*(x.^2)).^2)');
disp('4--> f(x) = sin( sqrt(x.^2 +100 ) )./ sqrt( x.^2+1)');
valorElegido = input('Ingrese un nro.entre 1 y 4  --> ');
switch valorElegido 
 case 1
    %===== f(x) = x^2 ======
   cmax = 25;
   % rango en el que varian cada argumento de la funcion
   limites = [-1; 5];
   paso = 0.01;
 case 2
   %===== f(x) = sin(x * pi ...) ======
   cmax = 3;
   % c/columna representa el rango en el que varia cada argumento de la funcion
   limites = [-2; 1];
   paso = 0.005;   %para el dibujo de la funcion        
   
 case 3
   %===== f(x) = 0.5+((sin( sqrt(x.^2) ).^2-0.5)./(1+0.001*(x.^2)).^2);  ======
   cmax = 1;
   % c/columna representa el rango en el que varia cada argumento de la funcion
   limites = [-50; 50];
   paso = 0.01;   %para el dibujo de la funcion    
   
  case 4
   %===== f(x) = sin( sqrt(x.^2 +100 ) )./ sqrt( x.^2+1);    ======
   cmax = 1;
   limites = [-50; 50];
   paso = 0.01;   %para el dibujo de la funcion    
end
