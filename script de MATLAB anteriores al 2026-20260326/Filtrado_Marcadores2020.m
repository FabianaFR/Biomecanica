%--------------------------------------------------------------------------
%------------------------------FILTRADO------------------------------------
%--------------------------------------------------------------------------
%Filtro de orden "Orden", frecuencia de corte "frec_corte" Hz ,
% frecuencia de muestreo "fm" Hz, frecuencia maxima frecuencia de muestreo sobre 2
% "PrimerFrame" es el primer dato a filtrar y UltimoFrame es el último dato
% a filtrar por ni no filtro todos los datos en el caso de que tenga NAN
% habitualmente

function Datos=A01TrisFiltrado_Marcadores(Datos,fm,frec_corte,Orden,PrimerFrame,UltimoFrame)

fe=fm/2;
wn=frec_corte/fe;
[B,A]=butter(Orden,wn);
Marcadores=fieldnames(Datos.Pasada.Marcadores.Crudos.Valores);
NumMarcadores=length(Marcadores);

for NumMar=1:NumMarcadores
    Mar=char(Marcadores{NumMar});
    Cord=Datos.Pasada.Marcadores.Crudos.Valores.(sprintf('%s',Mar));
    Datos.Pasada.Marcadores.filtrados.(sprintf('%s',Mar))=Cord;
    for i=1:3
        Cord=Datos.Pasada.Marcadores.Crudos.Valores.(sprintf('%s',Mar))(PrimerFrame:UltimoFrame,i);
        Cord = filtfilt(B,A,Cord);
        Datos.Pasada.Marcadores.filtrados.(sprintf('%s',Mar))(PrimerFrame:UltimoFrame,i)=Cord;
        %OPCIONAL de acuerdo al  lugar donde si quieren dejar a los
        % datos filtrados al interior de un subCampo "Valores"
        % Datos.Pasada.Marcadores.filtrados.Valores.(sprintf('%s',Mar))(PrimerFrame:UltimoFrame,i)=Cord;
    end;
end;
