function [deruno,derdos,dertres] = derivadas(uno,dos,tres,fm)

% function [deruno,derdos,dertres] = derivadas(uno,dos,tres,fm)
% Esta función devuelve las derivadas de las señales uno, dos y tres, las
% cuales fueron muestreadas con una frecuencia de muestreo fm. Uno, dos y
% tres serán vectores de una columna y n filas. Las señales derivadas
% deruno, derdos y dertres también serán vectores de nx1.
% El primer y el segundo valor del vector derivada serán iguales.
% Entradas:
% uno, dos y tres = cada uno es un vector [n x1] que se quiera derivar.
% fm = es la frecuencia de muestreo utilizada.

% Salidas
% deruno = vector de tamaño [n x 1], y que representa la derivada del
% vector uno. deruno[1]=deruno[n]=0.
% derdos = vector de tamaño [n x 1], y que representa la derivada del
% vector dos. derdos[1]=derdos[n]=0.
% dertres = vector de tamaño [n x 1], y que representa la derivada del
% vector tres. dertres[1]=dertres[n]=0.
% Paola Catalfamo 15-09-2020


deruno = zeros(size (uno));        % Armo las derivadas con la misma longitud, para no tener inconvenientes con la longitud de las señales
derdos = zeros(size (dos));
dertres = zeros(size (tres));

deltat=1/fm;

for n=2: (length (uno)) -1                 % n va desde 2 hasta fin-1
    
    deruno(n) = (uno(n+1) - uno(n-1)) ./ (2*deltat);
    
    derdos(n) = (dos(n+1) - dos(n-1)) ./ (2*deltat);
    
    dertres (n) = (tres(n+1) - tres(n-1)) ./ (2*deltat);
    
end;

deruno(1)= deruno(2);
derdos (1) = derdos (2);
dertres (1) = dertres (2);