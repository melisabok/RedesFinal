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

datos = csvread('car-num.csv');
clase = 2; % Very High
cantReglas = 5;
popSize = 50;
PSO_Multi(datos, clase, cantReglas, popSize, 1);