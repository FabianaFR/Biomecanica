
function [marcadores,informacionCine,Fuerzas,informacionFuerzas,Antropometria,Eventos,fileName] = leer_c3d()
% El llamado a esta funci�n permite cargar el archivo c3d. AHORA tiene la ventaja que los archivos pueden estar en cualquier carpeta del r�gido 
% y no hace falta cambiar de directorio. Este cambio permite conservar la ruta y el nombre del archivo y mantener el directorio actual sin mover.
% esta funci�n no requiere ningun par�metro de ida y regresa con par�mtros:
%  discriminnados en variable como se decribe en cada una 
 %"fileName" que es solamente el nombre del archivo que permite al llegar al "main" ver en el workspace el archivo sobre el que estoy trabajando

[fileName, filePath] = uigetfile('*.c3d'); % Se obtiene  el nombre y direccion del archivo con una ventana emergente
[h,~,~] = btkReadAcquisition([filePath fileName]); % Se obtiene un puntero al archivo c3d con el nombre y la ubicacion del archivo especificado
btkSetPointsUnit(h, 'marker', 'm')
[premarcadores informacionCine] = btkGetMarkers(h); % Se cargan los datos de los marcadores y la informaci�n cinematica a esas dos variables " marcadores" y "informacionCine"
[preFuerzas informacionFuerzas] = btkGetForcePlatforms(h);% Se cargan los datos datos dinamicas y la informaci�n de plataforma de fuerzas  a esas dos variables "Fuerzas" y "informacionFuerzas"
Fuerzas.Plataforma1.Valores=preFuerzas(1).channels;
Fuerzas.Plataforma1.Unidades=informacionFuerzas(1).units;
Fuerzas.Plataforma1.Frecuencia=informacionFuerzas(1).frequency;
Fuerzas.Plataforma2.Valores=preFuerzas(2).channels;
Fuerzas.Plataforma2.Unidades=informacionFuerzas(2).units;
Fuerzas.Plataforma2.Frecuencia=informacionFuerzas(2).frequency;

 [ANALOGS ANALOGSINFO] = btkGetAnalogs(h);
 
 Fuerzas.Plataforma1.Valores.CP1x=ANALOGS.CP1x; %coordenda "x" del Centro de Presión Plataforma1
 Fuerzas.Plataforma1.Valores.CP1y=ANALOGS.CP1y; %coordenda "y" del Centro de Presión Plataforma1
 Fuerzas.Plataforma2.Valores.CP2x=ANALOGS.CP2x; %coordenda "x" del Centro de Presión Plataforma2
 Fuerzas.Plataforma2.Valores.CP2y=ANALOGS.CP2y; %coordenda "y" del Centro de Presión Plataforma2

marcadores.Valores=premarcadores;
marcadores.Unidades=informacionCine.units.ALLMARKERS;
marcadores.Frecuencia=informacionCine.frequency;

preAntropometria=btkFindMetaData(h,'Antropometria'); % Se cargan los datos antropometricos en la variable Antropometria
DatosAntropometricos=fieldnames(preAntropometria.children);
for i=1:size(DatosAntropometricos,1)
    Ant=char(DatosAntropometricos{i});
    Valor=preAntropometria.children.(sprintf('%s',Ant)).info.values;
    Unidad= preAntropometria.children.(sprintf('%s',Ant)).description;
    Antropometria.(sprintf('%s',Ant)).Valor=Valor;
    Antropometria.(sprintf('%s',Ant)).Unidad=Unidad;
end
Eventos=btkGetEvents(h); % Se cargan los los datos de los instantes de tiempo en que se producen los eventos del ciclo de marcha en la variable Eventos
end


