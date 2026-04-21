 function [senialnormalizada] = InterpolaA100Muestras(senial); 
% function [senialnormalizada] = InterpolaA100Muestras(senial);
% Esta función recibe una señal en la variable "senial"
% y la interpola a 100 muestras en la variable senialporciento;
% La señal que ingresa es un vector nx1
% Y la senialnormalizada es un vector que contiene 1x100 datos
% y que nosotros entendemos como normalizada al ciclo de la marcha.
% Ejemplo de uso:
% [angulocaderanorm] = InterpolaA100Muestras(angulocadera);

 muestras = 1:1:length(senial);
 
 Porcentaje = 1:length(senial)/100:length(senial);
 
senialnormalizada  = interp1(muestras,senial,Porcentaje,'spline');