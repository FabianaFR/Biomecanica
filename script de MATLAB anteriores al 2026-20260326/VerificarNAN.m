function [Datos,HayNAN,QueMarcaEsNAN,Nombres] = VerificarNAN(Datos);
HayNAN = false;
subnivel=fieldnames(Datos.Pasada.Marcadores.Crudos.Valores);
NumeroDeElementos=size(subnivel,1);
QueMarcaEsNAN= zeros(NumeroDeElementos,1);
QueMarcaEsNAN=logical(QueMarcaEsNAN);
Nombres = subnivel;
for cont=1:NumeroDeElementos
    sub=char(subnivel{cont});
    variable= (sprintf('%s%s','Datos.Pasada.Marcadores.Crudos.Valores.',sub));
    Coordenada = eval(variable);
    TF=isnan(Coordenada);
    k= find(TF);
    if isempty(k)
       QueMarcaEsNAN(cont)=false; 
     else
        QueMarcaEsNAN(cont)=true; 
        HayNAN = true;
        Datos.Pasada.Marcadores.Crudos.Valores = rmfield(Datos.Pasada.Marcadores.Crudos.Valores,sub);
        Coordenada(isnan(Coordenada))=0;
        Datos.Pasada.Marcadores.Crudos.Valores.(sprintf('%s',sub))=Coordenada;
    end
end

  