function [Fpx, Fpy, Fpz] = calculofuerzas (masadelsegmento, aceleracionCentrodeMasa, Fdx, Fdy,Fdz)
% [Fpx, Fpy, Fpz] = calculofuerzas (masadelsegmento, aceleracionCentrodeMasa, Fdx, Fdy,Fdz)
% Esta función estima las fuerzas proximales a partir de los datos de masa
% del segmento, aceleración del centro de masa en sus tres componentes y
% Fuerzas distales.

% Entradas de la función:
%     Masa del segmento= valor numérico, en kg.
%     aceleraciónCentrodeMasaS = matriz nro_de_muestrasx3, en m/seg2;
%     Fdx, Fdy y Fdz= vectores nx1, de las fuerzas distales de reacción en la dirección x,y,z , en Newtons;

% Salidas de la función
%      Fpx, Fpy y Fpz= vectores nx1, de las fuerzas proximales de acción, en Newtons

% Ejemplo de llamado
% [Fxrod, Fyrod, Fzrod] = calculofuerzas (MasaPierna, aCMpierna, -Fxtob, -Fytob,-Fztob);


Fpx = masadelsegmento.*aceleracionCentrodeMasa (:,1) - Fdx;

Fpy = masadelsegmento.*aceleracionCentrodeMasa (:,2) - Fdy;

Fpz = masadelsegmento.*(aceleracionCentrodeMasa (:,3) + 9.81) - Fdz;
