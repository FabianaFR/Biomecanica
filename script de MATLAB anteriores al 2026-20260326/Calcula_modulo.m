%MODULO Esta función calcula el modulo de filas o columnas de una matriz.
%       Verifica si la fila o la columna tiene tres componentes y a esa dimensión le calcula el módulo (o longitud del vector pensando en el espacio vectorial) 
function MODULO = Calcula_modulo(matriz)
if length(matriz(1,:))==3
MODULO = sqrt(sum(abs(matriz).^2,2));
else
    if length(matriz(:,1))==3
    MODULO = sqrt(sum((matriz).^2,1));
    else
    MODULO=0;
    end
end
