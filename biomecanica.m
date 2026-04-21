clear all;

%%Lectura de los archivos

Archivo='C:\Users\alumno\Desktop\biomecanicaFabi\0029_Davis_Marcha01_Walking10b2021.c3d';
h=btkReadAcquisition(Archivo); %asignación de puntero
[marcadores,informacionCine]=btkGetMarkers(h);
[Fuerzas,informacionFuerzas]=btkGetForcePlatforms(h);
Antropometria=btkFindMetaData(h,'Antropometria');
Eventos=btkGetEvents(h);

%primer apoyo es el derecho

%% recorte y lectura de marcadores

fm=informacionCine.frequency(1);

RHS1=round(Eventos.Derecho_RHS(1)*fm);
RHS2=round(Eventos.Derecho_RHS(2)*fm);
RTO=round(Eventos.Derecho_RTO*fm);

LHS1=round(Eventos.Izquierdo_LHS(1)*fm);
LHS2=round(Eventos.Izquierdo_LHS(2)*fm);
LTO=round(Eventos.Izquierdo_LTO*fm);

inicio=RHS1;
fin=LHS2;

%script para cinematica 3D

p1=marcadores.r_met(inicio:fin,:);
p2=marcadores.r_heel(inicio:fin,:);
p3=marcadores.r_mall(inicio:fin,:);

p4=marcadores.r_bar_2(inicio:fin,:);
p5=marcadores.r_knee_1(inicio:fin,:);
p6=marcadores.r_bar_1(inicio:fin,:);

p7=marcadores.r_asis(inicio:fin,:);
p8=marcadores.l_met(inicio:fin,:);
p9=marcadores.l_heel(inicio:fin,:);

p10=marcadores.l_mall(inicio:fin,:);
p11=marcadores.l_bar_2(inicio:fin,:);
p12=marcadores.l_knee_1(inicio:fin,:);

p13=marcadores.l_bar_1(inicio:fin,:);
p14=marcadores.l_asis(inicio:fin,:);
p15=marcadores.sacrum(inicio:fin,:);



%%Filtrado de marcadores
fm= informacionCine.frequency; %frec de muestreo
fe= fm/2; %frec de Nyquist
wn= 10/fe; %elijo frecuencia de corte = 10Hz
[B,A] = butter(2,wn); %FILTRO pasabajo O2 serie de coeficientes, depende del numero de orden del filtro

for i=1:3
    p1(:,i)= filtfilt(B,A,p1(:,i));
    p2(:,i)= filtfilt(B,A,p2(:,i));
    p3(:,i)= filtfilt(B,A,p3(:,i));
    p4(:,i)= filtfilt(B,A,p4(:,i));
    p5(:,i)= filtfilt(B,A,p5(:,i));
    p6(:,i)= filtfilt(B,A,p6(:,i));
    p7(:,i)= filtfilt(B,A,p7(:,i));
    p8(:,i)= filtfilt(B,A,p8(:,i));
    p9(:,i)= filtfilt(B,A,p9(:,i));
    p10(:,i)= filtfilt(B,A,p10(:,i));
    p11(:,i)= filtfilt(B,A,p11(:,i));
    p12(:,i)= filtfilt(B,A,p12(:,i));
    p13(:,i)= filtfilt(B,A,p13(:,i));
    p14(:,i)= filtfilt(B,A,p14(:,i));
    p15(:,i)= filtfilt(B,A,p15(:,i));
end

%figure;
%plot(p3(:,3)); hold on; plot(p3f(:,3));
%%Datos antropometricos
%A2 es anterior superior iliac spine breath
%A11 es Right Knee Diameter

%NUEVO PARA CINETICA: PESO Y ALTURA
A1= Antropometria.children.PESO.info.values; %peso en kg
altura = Antropometria.children.ALTURA.info.values, %altura en cm, se pasa a metros-> /100

A2= Antropometria.children.LONGITUD_ASIS.info.values/100;
A11= Antropometria.children.DIAMETRO_RODILLA_DERECHA.info.values/100;
A12= Antropometria.children.DIAMETRO_RODILLA_IZQUIERDA.info.values/100;

A13= Antropometria.children.LONGITUD_PIE_DERECHO.info.values/100;
A14= Antropometria.children.LONGITUD_PIE_IZQUIERDO.info.values/100;

A15= Antropometria.children.ALTURA_MALEOLOS_DERECHO.info.values/100;
A16= Antropometria.children.ALTURA_MALEOLOS_IZQUIERDO.info.values/100;

A17= Antropometria.children.ANCHO_MALEOLOS_DERECHO.info.values/100;
A18= Antropometria.children.ANCHO_MALEOLOS_IZQUIERDO.info.values/100;

A19= Antropometria.children.ANCHO_PIE_DERECHO.info.values/100;
A20= Antropometria.children.ANCHO_PIE_IZQUIERDO.info.values/100;



%% Calculo de u,v,w PARA CENTRO ARTICULAR CADERA

%calculo de v de pelvis
Avp= p14-p7; %[x y z]
Bvp= Avp.^2; %Elevo todo al cuadrado x^2,y^2,z^2
normvp= sqrt(sum(Bvp,2)); %Aplico raiz para calcular la norma (proceso que se hace fila por fila)
for i=1: size(Avp,1)
    vpelvis(i,:)=Avp(i,:)/normvp(i);
end

%calculo de w de pelvis
Aw=(p7-p15);
Bw=(p14-p15);
Cw = cross(Aw,Bw);
normwp= sqrt(sum(Cw.^2,2));
for i=1: size(Aw,1)
    wpelvis(i,:)=Cw(i,:)/normwp(i);
end

%calculo de u de pelvis
upelvis= cross(vpelvis,wpelvis);

%CENTROS ARTICULARES
%Para el calculo de la posicion de la cadera derecha y de la izquierda...
prhip= p15+ 0.598*A2*upelvis - 0.344*A2*vpelvis - 0,290*A2*wpelvis;
plhip= p15+ 0.598*A2*upelvis + 0.344*A2*vpelvis - 0,290*A2*wpelvis;



%% Calculo de u,v,w PARA CENTRO ARTICULAR RODILLA

%RODILLA DERECHA
%calculo de v de rodilla
RAvp= p3-p5; %[x y z]
RBvp= RAvp.^2; %Elevo todo al cuadrado x^2,y^2,z^2
Rnormvp= sqrt(sum(RBvp,2)); %Aplico raiz para calcular la norma (proceso que se hace fila por fila)
for i=1: size(RAvp,1)
    Rvrodilla(i,:)=RAvp(i,:)/Rnormvp(i);
end

%calculo de u de rodilla
RAu=(p4-p5);
RBu=(p3-p5);
RCu = cross(RAu,RBu);
Rnormup= sqrt(sum(RCu.^2,2));
for i=1: size(RAu,1)
    Rurodilla(i,:)=RCu(i,:)/Rnormup(i);
end

%calculo de w de rodilla
Rwrodilla= cross(Rurodilla,Rvrodilla);
%centro articular rodilla derecha
rprodilla = p5 + A11*Rurodilla + A11*Rvrodilla + 0.5*A11*Rwrodilla;

%RODILLA IZQUIERDA
%calculo de v de rodilla
LAvp= p10-p12; %[x y z]
LBvp= LAvp.^2; %Elevo todo al cuadrado x^2,y^2,z^2
Lnormvp= sqrt(sum(LBvp,2)); %Aplico raiz para calcular la norma (proceso que se hace fila por fila)
for i=1: size(LAvp,1)
    Lvrodilla(i,:)=LAvp(i,:)/Lnormvp(i);
end

%calculo de u de rodilla (u va hacia adelante)
LAu=(p10-p12);
LBu=(p11-p12);
LCu = cross(LAu,LBu);
Lnormup= sqrt(sum(LCu.^2,2));
for i=1: size(LAu,1)
    Lurodilla(i,:)=LCu(i,:)/Lnormup(i);
end

%calculo de w de rodilla
Lwrodilla= cross(Lvrodilla,Lurodilla);
%centro articular rodilla izquierda
lprodilla = p12 + A12*Lurodilla + A12*Lvrodilla - 0.5*A12*Lwrodilla;



%% Graficos de marcadores
figure
%cadera
plot3(p15(:,1),p15(:,2),p15(:,3),'r','LineWidth',2)
hold on;
plot3(p7(:,1),p7(:,2),p7(:,3),'r','LineWidth',2)
hold on;
plot3(p14(:,1),p14(:,2),p14(:,3),'r','LineWidth',2)
hold on;
%miembro inferior derecho
plot3(p6(:,1),p6(:,2),p6(:,3),'k','LineWidth',2)
hold on;
plot3(p5(:,1),p5(:,2),p5(:,3),'k','LineWidth',2)
hold on;
plot3(p3(:,1),p3(:,2),p3(:,3),'k','LineWidth',2)
hold on;
%miembro inferior izquierdo
plot3(p13(:,1),p13(:,2),p13(:,3),'b','LineWidth',2)
hold on;
plot3(p12(:,1),p12(:,2),p12(:,3),'b','LineWidth',2)
hold on;
plot3(p10(:,1),p10(:,2),p10(:,3),'b','LineWidth',2)
hold on;


%% GRAFICO DE VERSORES
% CADERA quiver permite graficar versores o vectores
for i=1:10:length(p15)
    quiver3(p15(i,1),p15(i,2),p15(i,3),upelvis(i,1)./10,upelvis(i,2)./10,upelvis(i,3)./10,'b');
    hold on;
    quiver3(p15(i,1),p15(i,2),p15(i,3),vpelvis(i,1)./10,vpelvis(i,2)./10,vpelvis(i,3)./10,'r');
    hold on;
    quiver3(p15(i,1),p15(i,2),p15(i,3),wpelvis(i,1)./10,wpelvis(i,2)./10,wpelvis(i,3)./10,'g');
    hold on;
end
% RODILLA DERECHA
for i=1:10:length(p5)
    quiver3(p5(i,1),p5(i,2),p5(i,3),Rurodilla(i,1)./10,Rurodilla(i,2)./10,Rurodilla(i,3)./10,'b');
    hold on;
    quiver3(p5(i,1),p5(i,2),p5(i,3),Rvrodilla(i,1)./10,Rvrodilla(i,2)./10,Rvrodilla(i,3)./10,'r');
    hold on;
    quiver3(p5(i,1),p5(i,2),p5(i,3),Rwrodilla(i,1)./10,Rwrodilla(i,2)./10,Rwrodilla(i,3)./10,'g');
    hold on;
end
% RODILLA IZQUIERDA
for i=1:10:length(p12)
    quiver3(p12(i,1),p12(i,2),p12(i,3),Lurodilla(i,1)./10,Lurodilla(i,2)./10,Lurodilla(i,3)./10,'b');
    hold on;
    quiver3(p12(i,1),p12(i,2),p12(i,3),Lvrodilla(i,1)./10,Lvrodilla(i,2)./10,Lvrodilla(i,3)./10,'r');
    hold on;
    quiver3(p12(i,1),p12(i,2),p12(i,3),Lwrodilla(i,1)./10,Lwrodilla(i,2)./10,Lwrodilla(i,3)./10,'g');
    hold on;
end

legend('Marcador del Sacro', 'Marcador del ASIS derecho','Marcador del ASIS izquierdo','u de pelvis','v de pelvis','w de pelvis');
xlabel('Eje X');
ylabel('Eje y');
zlabel ('Eje z');
title('Trayectoria de marcadores y diagrama de u,v,w sobre el marcador sacro')
grid on;





