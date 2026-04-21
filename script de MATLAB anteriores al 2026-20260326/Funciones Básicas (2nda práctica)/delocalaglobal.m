function [variableglobal] = delocalaglobal (i, j, k, variablelocal) 
% Esta función transforma una variable expresada en las coordenadas locales
% del segmento, a la misma variable expresada en coordenadas globales.

% Entradas:
% i, j y k = cada uno es una matriz de tamaño nro de muestras x 3 y
% contiene en cada fila, el vector del segmento en una dada muestra y en
% cada columna la componente en x, y y z del vector.

% variable local = es una matriz de tamaño nro de muestras x 3 y en cada fila
% contiene el vector para una dada muestra. Esta variable esta expresada en
% coordenadas locales del segmento.

%Salidas:
% variable global = es la matriz de la misma variable de entrada, expresada
% en coordenadas globales del laboratorio. Tiene un tamaño de nro de
% muestras x 3, donde cada fila contiene el vectora para una dada muestra.


for n=1:length(variablelocal)
    
    matrizderotacion= [ i(n,:);  j(n,:);  k(n,:)]; % =      [  ix    iy     iz; 
                                                                        %    jx     jy     jz;
                                                                        %    kx    ky   kz];
                                                                        
    matrizderotacion = matrizderotacion';    % =  [  ix    jx   kx
                                                                    %     iy    jy   ky
                                                                     %    iz    jz    kz];
    
   
   auxiliarglobal = variablelocal (n,:)';                    % mlocal = [mlocalx    mlocaly   mlocalz];
                                                                           % auxiliarglobal =  [ mlocalx
                                                                           %                               mlocaly
                                                                           %                               mlocalz];
                                                                           
   
   auxiliarglobal2 = matrizderotacion*auxiliarglobal;       % Ahora sí la multiplicación de matriz por columna
                                                                                              % El resultado de esto es una columna. Sin embargo, en realidad, es el Momento global en su primer instante, entonces es fila.
   
   
    variableglobal (n,:) =auxiliarglobal2';         % Traspuesta para hacerla fila y guardarla como la fila n de la variable global.
    
end;