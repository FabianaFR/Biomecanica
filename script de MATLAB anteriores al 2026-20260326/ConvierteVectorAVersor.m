%ConvierteVectorAVersor: Este función calcula los versores de una matriz  organizado ya sea  filas o columnas de una matriz.
%       Verifica si la fila o la columna tiene tres componentes y a esa dimensión  le calcula el módulo 
%        modulo = Calcula_modulo(MATRIZ) y con ese modulo se genera tres
%        valores iguales para dividir punto a punto entre matrices
 
function versor=ConvierteVectorAVersor(vector)
modulo=Calcula_modulo(vector);
if length(modulo(:,1))>length(modulo(1,:))
    modulo=[modulo,modulo,modulo];
else
    modulo=[modulo;modulo;modulo];
end
versor=vector./modulo;
end