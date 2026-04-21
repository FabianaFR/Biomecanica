function [DerechaPlataforma1,PrimerFrame,UltimoFrame,FrameRHS1,FrameLHS1,FrameRHS2,FrameLHS2,FrameRTO,FrameLTO] = Ciclo2Pasos(Datos);
% La función "Ciclo2Pasos" Recibe como parámetro la estuctura de "Datos"
% completa no la modifica, pero si devuelve los parametros convertidos en
% frame (cuadros) en los que se producen los eventos de apoyo del taón y
%  despegue de la punta del pie que permiten recortar los datos de cada
%  ciclo ixquierdo y derecho. Además se indica en "DerechaPlataforma1" con
%  una variable booleana si pisa primero con el pie derecho

FRate= Datos.Pasada.Marcadores.Crudos.Frecuencia;
TiempoRHS=Datos.eventos.Derecho_RHS(1);
TiempoLHS=Datos.eventos.Izquierdo_LHS(1);

FrameRHS1=round(Datos.eventos.Derecho_RHS(1)*FRate);
FrameLHS1=round(Datos.eventos.Izquierdo_LHS(1)*FRate);
FrameRHS2=round(Datos.eventos.Derecho_RHS(2)*FRate);
FrameLHS2=round(Datos.eventos.Izquierdo_LHS(2)*FRate);
FrameRTO=round(Datos.eventos.Derecho_RTO*FRate);
FrameLTO=round(Datos.eventos.Izquierdo_LTO*FRate);


if (TiempoRHS < TiempoLHS) 
    PrimerFrame = round((TiempoRHS*FRate));
    UltimoFrame = round((Datos.eventos.Izquierdo_LHS(2)*FRate));
    DerechaPlataforma1 = true;
else
    PrimerFrame = round((TiempoLHS*FRate)) ;
    UltimoFrame = round((Datos.eventos.Derecho_RHS(2)*FRate));
    DerechaPlataforma1 = false;
end
