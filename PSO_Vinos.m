clear
clc

datos = csvread('Vinos.csv');
[CantRows, CantCols] = size(datos);
P = escalar(datos, 2:Cols);

popsize = 30;
elitismo = 1;  % el mejor NO se mueve

MAX_ITERA = 500;



