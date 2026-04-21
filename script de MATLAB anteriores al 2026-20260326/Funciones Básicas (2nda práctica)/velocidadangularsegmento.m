function [wx,wy,wz] = velocidadangularsegmento (alfa, deralfa, beta, derbeta, gama,dergama)
% function [wx,wy,wz] = velocidadangularsegmento (alfa, deralfa, beta, derbeta, gama,dergama);
% Esta función calcula las velocidades angulares de los segmentos en
% coordenadas locales, a partir de los ángulos de Euler alfa, beta, gama y
% sus derivadas expresadas en coordenadas locales.

% Entradas:
% Todas las entradas son vectores de tamaño n x 1, donde n es el número de
% muestras correspondientes a dos ciclos completos de la marcha.
% alfa= angulo alfa del segmento de interés
% deralfa = derivada del ángulo alfa del segmento de interés
% beta= angulo beta del segmento de interés
% derbeta = derivada del ángulo beta del segmento de interés
% gama= angulo gamma del segmento de interés
% dergama = derivada del ángulo gamma del segmento de interés

% Salidas de la función
% Todas las salidas son vectores de tamaño nx1, donde n es el número de
% muestras correspondientes a dos ciclos completos de la marcha.

% wx = velocidad angular del segmento de interés en la dirección x (es
% decir en la dirección i local), wx está expresado en coordenadas locales

% wy = velocidad angular del segmento de interés en la dirección y (es
% decir en la dirección j local), wy está expresado en coordenadas locales

% wz = velocidad angular del segmento de interés en la dirección z (es
% decir en la dirección k local), wx está expresado en coordenadas locales

% Ejemplo de cómo llamar a la función para el segmento MUSLO DERECHO:
% [wxmusder,wymusder,wzmusder] = velocidadangularsegmento (alfamusder, deralfamusder, betamusder, derbetamusder, gamamusder,dergamamusder)

wx= deralfa.*sind(beta).*sind(gama) + derbeta.*cosd(gama);
wy = deralfa.* sind(beta).*cosd(gama) - derbeta.*sind(gama);
wz = deralfa.*cosd(beta) + dergama;


