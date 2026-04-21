%--- Recortado hacia adentro ---------------
%--------------------------------------------------------------------------
function [Datos] = RecortaDatos(Datos,PrimerMuestra,UltimaMuestra);
subnivel=fieldnames(Datos.Pasada.Marcadores.Crudos.Valores);
tamano=size(subnivel)
CantidadFilas= tamano(1)
for cont=1:CantidadFilas
    sub=char(subnivel{cont});
    
    variable= (sprintf('%s%s','Datos.Pasada.Marcadores.Crudos.Valores.',sub));
    Coordenada = eval(variable);
    Datos.Pasada.Marcadores.Crudos.Valores = rmfield( Datos.Pasada.Marcadores.Crudos.Valores,sub);
    
    Datos.Pasada.Marcadores.Crudos.Valores.(sprintf('%s',sub))=Coordenada(PrimerMuestra:UltimaMuestra,:);
end


