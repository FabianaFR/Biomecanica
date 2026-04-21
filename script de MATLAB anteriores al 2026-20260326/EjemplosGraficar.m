 CATEDRA DE BIOMECANICA FI UNER
% Plantilla guia para graficacion de variables%

% pos_A y pos_B son datos de posición cualesquiera de tamaño Nx3
% y vectorAB es un vector diferencia entre esos puntos


% ----------------------------------------------------------------------
% FUNCION PLOT(X,Y) O PLOT(X) GRAFICA LA VARIABLE Y VERSUS X, 
% O LA VARIABLE X EN FUNCION DE SU INDICE SE LE PUEDE COLOCAR 
% COMO PARAMETRO EL COLOR ('r' 'g' 'b' 'k' 'g' 'm' 'c') DE LINEA O CARACTER
% ESTIPULAR EL CARACTER ('*' '+'  '-' '.-' 'o')
% EL GROSOR DE LA LINEA 'LineWidth',2
% EL TAMAÑO DEL MARCADOR  'MarkerSize',10
%Una Posible asignación de marcadores
% posA=Datos.Pasada.Marcadores.Crudos.sacrum;
% posB=Datos.Pasada.Marcadores.Crudos.r_asis;
% posC=Datos.Pasada.Marcadores.Crudos.l_asis;

figure(1);
plot(posA(:,1),posA(:,3),'+m');
title('Trayectoria posA en el plano XZ');
legend('PosA en plano XZ');
xlabel('Eje X [mts] ');
ylabel('Eje Z [mts]');


figure(2);
plot(posA);
title('Compenentes xyz de la matriz posA');
legend('Comp x','Comp y','Comp z');
xlabel('Frames');
ylabel('Posición [mts]');

figure(3);
plot(posA(:,1),posA(:,3),'+m');
hold on;
plot(posB(:,1),posB(:,3),'+g');
title('Trayectoria en el plano XZ de Pos A y Pos B');
legend('PosB plano XZ','PosA plano XZ');
xlabel('Eje X [mts] ');
ylabel('Eje Z [mts]');

% Las funciones TITLE, LEGEND X_Y_Z_LABEL aceptan strings (texto entre comillas simples)
% para dar información sobre la figura como  titulo, referencia sobre las variables y etiquetas 
% a los ejes coordenados.

% La funcion hold on permite sostener abierta la ventana de la figura para agregar más gráficas
% a la misma ventana.

% ----------------------------------------------------------------------
% FUNCION PLOT3(X,Y,Z)  GRAFICA LA TRAYECTORIA DE LA POSICION
% EN EL ESPACIO 3D 

figure(4);
plot3(posA(:,1),posA(:,2),posA(:,3),'*b');
hold on;
plot3(posB(:,1),posB(:,2),posB(:,3),'*r');
plot3(0,0,0,'ko');
title('Trayectoria de la PosA');
legend('Pos A 3D','Pos B 3D');
xlabel('Eje X [mts]');
ylabel('Eje Y [mts]');
zlabel('Eje Z [mts]');
grid on;
view(200,30) ;


% La funcion grid on agrega una grilla para orientación de la disposicion del espacio 3D
% La función view predetermina la vista de la grafica 3D mediante AZIMUD y la ELEVACION
% view(2) provee la vista superior por defecto 2-D: AZ = 0, EL = 90 .
% view(3) sets the default 3-D: AZ = -37.5, EL = 30.

% ----------------------------------------------------------------------
% FUNCION LINE (X,Y,Z) CREA LINEAS EN COORDENADAS 3D.
% Si se le pasa como argumentos pares de coordenadas para cada eje dibuja
% segmentos de recta entre la primer y segunda triada de datos.

figure(5);
plot3(0,0,0,'ko');
title('Segmento de recta y Extremos');
xlabel('Eje X [mts]');
ylabel('Eje Y [mts]');
zlabel('Eje Z [mts]');
axis([-1 1 -1 0 0 1])
grid on;
hold on;

for i=1:10:length(posA);
        x=[posA(i,1), posB(i,1)];
        y=[posA(i,2), posB(i,2)];
        z=[posA(i,3), posB(i,3)];
        line(x,y,z,'color',[.8 .3 .8]);
        x=[posA(i,1), posC(i,1)];
        y=[posA(i,2), posC(i,2)];
        z=[posA(i,3), posC(i,3)];
        line(x,y,z,'color',[.3 .8 .8]);
        x=[posC(i,1), posB(i,1)];
        y=[posC(i,2), posB(i,2)];
        z=[posC(i,3), posB(i,3)];
        line(x,y,z,'color',[.8 .8 .3]);
        
        plot3(posA(i,1),posA(i,2),posA(i,3),'*g');
        plot3(posB(i,1),posB(i,2),posB(i,3),'*b');
        plot3(posC(i,1),posC(i,2),posC(i,3),'*r');
        pause(1/50);
end

% La funcion AXIS permite setear un rango fijo para los ejes y evitar el auto escalado. 
% La función PAUSE permite introducir un periodo de espera entre una imagen 
% y la siguiente. Por defecto es de 1 seg, pero se puede ingresar como argumento
% otro valor.

% ----------------------------------------------------------------------
% FUNCION QUIVER3 PERMITE GRAFICAR UN VECTOR 3D UBICANDO SU ORIGEN
% EN UNA POSICIÓN DE REFERENCIA.


figure(6)
plot3(posA(:,1),posA(:,2),posA(:,3),'+k');
hold on;
% plot3(posB(:,1),posB(:,2),posB(:,3),'+k');
vectorAB = posB - posA;


quiver3(posA(:,1),posA(:,2),posA(:,3),vectorAB(:,1),vectorAB(:,2),vectorAB(:,3), 'm');

% quiver3(posB(:,1),posB(:,2),posB(:,3),-vectorAB(:,1),-vectorAB(:,2),-vectorAB(:,3), 'c');

% Origen de coordenadas
quiver3(0,0,0,1,0,0, 'r');
quiver3(0,0,0,0,1,0, 'g');
quiver3(0,0,0,0,0,1, 'b');

title('Posición y Vector');
xlabel('Eje X [mts]');
ylabel('Eje Y [mts]');
zlabel('Eje Z [mts]');
grid on;
 
% ----------------------------------------------------------------------
% --------------------------JTP Melisa Frisoli--------------------------
% ----------------------------------------------------------------------
