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

%Para el calculo de la posicion de la cadera derecha y de la izquierda...
prhip= p15+ 0.598*A2*upelvis - 0.344*A2*vpelvis - 0,290*A2*wpelvis;
plhip= p15+ 0.598*A2*upelvis + 0.344*A2*vpelvis - 0,290*A2*wpelvis;


%% CALCULO U V W PARA CENTRO ARTICULAR RODILLAS
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

% RODILLA IZQUIERDA
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
Lwrodilla= cross(Lurodilla,Lvrodilla);

%centro articular rodilla derecha
prknee = p5 + 0.0*A11*Rurodilla + 0.0*A11*Rvrodilla + 0.5*A11*Rwrodilla;
%centro articular rodilla izquierda
plknee= p12 + 0.0*A12*Lurodilla + 0.0*A12*Lvrodilla - 0.5*A12*Lwrodilla;


%% CALCULO U V W PARA CENTRO ARTICULAR PIE Y TOBILLO
% PIE DERECHO
%calculo de u de pie
RTAup= p1-p2; %[x y z]
RTBup= RTAup.^2; %Elevo todo al cuadrado x^2,y^2,z^2
RTnormup= sqrt(sum(RTBup,2)); %Aplico raiz para calcular la norma (proceso que se hace fila por fila)
for i=1: size(RTAup,1)
    Rupie(i,:)=RTAup(i,:)/RTnormup(i);
end

%calculo de w de pie
RTAw=(p1-p3);
RTBw=(p2-p3);
RTCw = cross(RTAw,RTBw);
RTnormwp= sqrt(sum(RTCw.^2,2));
for i=1: size(RTAw,1)
    Rwpie(i,:)=RTCw(i,:)/RTnormwp(i);
end

%calculo de v de pie
Rvpie= cross(Rwpie,Rupie);

%centro articular pie derecho y tobillo derecho
prtoe = p3 + 0.742*A13*Rupie + 1.074*A15*Rvpie - 0.187*A19*Rwpie;
prtobillo = p3 + 0.016*A13*Rupie + 0.392*A15*Rvpie + 0.478*A17*Rwpie;

%PIE IZQUIERDO
%calculo de u de pie
LTAup= p8-p9; %[x y z]
LTBup= LTAup.^2; %Elevo todo al cuadrado x^2,y^2,z^2
LTnormup= sqrt(sum(LTBup,2)); %Aplico raiz para calcular la norma (proceso que se hace fila por fila)
for i=1: size(LTAup,1)
    Lupie(i,:)=LTAup(i,:)/LTnormup(i);
end

%calculo de w de pie
LTAw=(p8-10);
LTBw=(p9-p10);
LTCw = cross(LTAw,LTBw);
LTnormwp= sqrt(sum(LTCw.^2,2));
for i=1: size(LTAw,1)
    Lwpie(i,:)=LTCw(i,:)/LTnormwp(i);
end

%calculo de v de pie
Lvpie= cross(Lwpie,Lupie);

% centro articular pie izquierdo y tobillo izquierdo
pltoe= p10 + 0.742*A14*Lupie + 1.074*A16*Lvpie + 0.187*A20*Lwpie;
pltobillo = p10 + 0.016*A14*Lupie + 0.392*A16*Lvpie - 0.478*A18*Lwpie;


%% CALCULO DE CENTROS DE MASA DEL MUSLO - PIERNA - PIE
CMPmusR = prhip + 0.39*(prknee - prhip)
CMPmusL = plhip + 0.39*(plknee - plhip)

CMPcalfR = prknee + 0.42*(prtobillo - prknee)
CMPcalfL = plknee + 0.42*(pltobillo - plknee)

CMPfootR = p2 + 0.44*(prtoe-p2)
CMPfootL = p9 + 0.44*(pltoe-p9)


%% CALCULO DE VERSORES I J K DE SEGMENTOS PELVIS Y MUSLO

% SEGMENTO PELVIS
ihip = wpelvis;
jhip = upelvis;
khip = vpelvis;

% SEGMENTO MUSLO DERECHO
% versor i
imusAr= prhip - prknee;
imusBr= imusAr.^2;
iMRnorma= sqrt(sum(imusBr,2));
for i=1: size(imusAr,1)
    i1(i,:)=imusAr(i,:)/iMRnorma(i); %versor i para el muslo derecho
end

% versor j
jmusAr=(p6-prhip);
jmusBr=(prknee-prhip);
jmusCr = cross(jmusAr,jmusBr);
jMRnorma= sqrt(sum(jmusCr.^2,2));
for i=1: size(jmusAr,1)
    j1(i,:)=jmusCr(i,:)/jMRnorma(i); %versor j para el mulso derecho
end

% versor k
k1= cross(i1,j1); %versor k para el muslo derecho

% SEGMENTO MUSLO IZQUIERDO
% versor i
imusAl= plhip - plknee;
imusBl= imusAl.^2;
iMLnorma= sqrt(sum(imusBl,2));
for i=1: size(imusAl,1)
    i2(i,:)=imusAl(i,:)/iMLnorma(i); %versor i para el muslo izquierdo
end

% versor j
jmusAl=(plknee-plhip);
jmusBl=(p13-plhip);
jmusCl = cross(jmusAl,jmusBl);
jMLnorma= sqrt(sum(jmusCl.^2,2));
for i=1: size(jmusAl,1)
    j2(i,:)=jmusCl(i,:)/jMLnorma(i); %versor j para el mulso izquierdo
end

% versor k
k2= cross(i2,j2); %versor k para el muslo izquierdo



%% SEGMENTOS PIERNA DERECHA E IZQUIERDA  i3,j3,k3   i4,j4,k4
% PIERNA DERECHA
% versor i
icalfAr= prknee - prtobillo;
icalfBr= icalfAr.^2;
iCRnorma= sqrt(sum(icalfBr,2));
for i=1: size(icalfAr,1)
    i3(i,:)=icalfAr(i,:)/iCRnorma(i);
end

% versor j
jcalfAr=(p5-prknee);
jcalfBr=(prtobillo-prknee);
jcalfCr = cross(jcalfAr,jcalfBr);
jCRnorma= sqrt(sum(jcalfCr.^2,2));
for i=1: size(jcalfAr,1)
    j3(i,:)=jcalfCr(i,:)/jCRnorma(i);
end

% versor k
k3= cross(i3,j3);

% PIERNA IZQUIERDA
% versor i
icalfAl= plknee - pltobillo;
icalfBl= icalfAl.^2;
iCLnorma= sqrt(sum(icalfBl,2));
for i=1: size(icalfAl,1)
    i4(i,:)=icalfAl(i,:)/iCLnorma(i);
end

% versor j
jcalfAl=(pltobillo-plknee);
jcalfBl=(p12-plknee);
jcalfCl = cross(jcalfAl,jcalfBl);
jCLnorma= sqrt(sum(jcalfCl.^2,2));
for i=1: size(jcalfAl,1)
    j4(i,:)=jcalfCl(i,:)/jCLnorma(i);
end

% versor k
k4= cross(i4,j4);



%% SEGMENTO PIE VERSORES i5,j5,k5   i6,j6,k6
% PIE DERECHO
% versor i
ifootAr= p2 - prtoe;
ifootBr= ifootAr.^2;
iFRnorma= sqrt(sum(ifootBr,2));
for i=1: size(ifootAr,1)
    i5(i,:)=ifootAr(i,:)/iFRnorma(i);
end

% versor K
kfootAr=(prtobillo-p2);
kfootBr=(prtoe-p2);
kfootCr = cross(kfootAr,kfootBr);
kFRnorma= sqrt(sum(kfootCr.^2,2));
for i=1: size(kfootAr,1)
    k5(i,:)=kfootCr(i,:)/kFRnorma(i);
end

% versor k
j5= cross(k5,i5);

%PIE IZQUIERDO
% versor i
ifootAl= p9 - pltoe;
ifootBl= ifootAl.^2;
iFLnorma= sqrt(sum(ifootBl,2));
for i=1: size(ifootAl,1)
    i6(i,:)=ifootAl(i,:)/iFLnorma(i);
end

% versor k
kfootAl=(pltobillo-p9);
kfootBl=(pltoe-p9);
kfootCl = cross(kfootAl,kfootBl);
kFLnorma= sqrt(sum(kfootCl.^2,2));
for i=1: size(kfootAl,1)
    k6(i,:)=kfootCl(i,:)/kFLnorma(i);
end

% versor j
j6= cross(k6,i6);

%% GRAFICAS DE IJK PARA MUSLOS PIERNA Y PIE
figure;
plot3(p15(:,1),p15(:,2), p15(:,3),'k','LineWidth',2)
hold on;
plot3(CMPmusR(:,1),CMPmusR(:,2), CMPmusR(:,3),'r','LineWidth',2)
hold on;
plot3(CMPmusL(:,1),CMPmusL(:,2), CMPmusL(:,3),'Y','LineWidth',2)
hold on;
plot3(CMPcalfR(:,1),CMPcalfR(:,2), CMPcalfR(:,3),'b','LineWidth',2)
hold on;
plot3(CMPcalfL(:,1),CMPcalfL(:,2), CMPcalfL(:,3),'b','LineWidth',2)
hold on;
plot3(CMPfootR(:,1),CMPfootR(:,2), CMPfootR(:,3),'b','LineWidth',2)
hold on;
plot3(CMPfootL(:,1),CMPfootL(:,2), CMPfootL(:,3),'b','LineWidth',2)
hold on;

%cadera
for i = 1:20:length(p15)
    quiver3(p15(i,1),p15(i,2), p15(i,3), ihip(i,1)./10, ihip(i,2)./10, ihip(i,3)./10, 'r');
    hold on;
    quiver3(p15(i,1),p15(i,2), p15(i,3), jhip(i,1)./10, jhip(i,2)./10, jhip(i,3)./10, 'g');
    hold on;
    quiver3(p15(i,1),p15(i,2), p15(i,3), khip(i,1)./10, khip(i,2)./10, khip(i,3)./10, 'b');
end

%muslo derecho
for i = 1:20:length(p15)
    quiver3(CMPmusR(i,1),CMPmusR(i,2), CMPmusR(i,3), i1(i,1)./10, i1(i,2)./10, i1(i,3)./10, 'r');
    hold on;
    quiver3(CMPmusR(i,1),CMPmusR(i,2), CMPmusR(i,3), j1(i,1)./10, j1(i,2)./10, j1(i,3)./10, 'g');
    hold on;
    quiver3(CMPmusR(i,1),CMPmusR(i,2), CMPmusR(i,3), k1(i,1)./10, k1(i,2)./10, k1(i,3)./10, 'b');
end
%muslo izquierdo
for i = 1:20:length(p15)
    quiver3(CMPmusL(i,1),CMPmusL(i,2), CMPmusL(i,3), i2(i,1)./10, i2(i,2)./10, i2(i,3)./10, 'r');
    hold on;
    quiver3(CMPmusL(i,1),CMPmusL(i,2), CMPmusL(i,3), j2(i,1)./10, j2(i,2)./10, j2(i,3)./10, 'g');
    hold on;
    quiver3(CMPmusL(i,1),CMPmusL(i,2), CMPmusL(i,3), k2(i,1)./10, k2(i,2)./10, k2(i,3)./10, 'b');
end

%pierna derecha
for i = 1:20:length(p15)
    quiver3(CMPcalfR(i,1),CMPcalfR(i,2), CMPcalfR(i,3), i3(i,1)./10, i3(i,2)./10, i3(i,3)./10, 'r');
    hold on;
    quiver3(CMPcalfR(i,1),CMPcalfR(i,2), CMPcalfR(i,3), j3(i,1)./10, j3(i,2)./10, j3(i,3)./10, 'g');
    hold on;
    quiver3(CMPcalfR(i,1),CMPcalfR(i,2), CMPcalfR(i,3), k3(i,1)./10, k3(i,2)./10, k3(i,3)./10, 'b');
end
%pierna izquierda
for i = 1:20:length(p15)
    quiver3(CMPcalfL(i,1),CMPcalfL(i,2), CMPcalfL(i,3), i4(i,1)./10, i4(i,2)./10, i4(i,3)./10, 'r');
    hold on;
    quiver3(CMPcalfL(i,1),CMPcalfL(i,2), CMPcalfL(i,3), j4(i,1)./10, j4(i,2)./10, j4(i,3)./10, 'g');
    hold on;
    quiver3(CMPcalfL(i,1),CMPcalfL(i,2), CMPcalfL(i,3), k4(i,1)./10, k4(i,2)./10, k4(i,3)./10, 'b');
end

%pie derecho
for i = 1:20:length(p15)
    quiver3(CMPfootR(i,1),CMPfootR(i,2), CMPfootR(i,3), i5(i,1)./10, i5(i,2)./10, i5(i,3)./10, 'r');
    hold on;
    quiver3(CMPfootR(i,1),CMPfootR(i,2), CMPfootR(i,3), j5(i,1)./10, j5(i,2)./10, j5(i,3)./10, 'g');
    hold on;
    quiver3(CMPfootR(i,1),CMPfootR(i,2), CMPfootR(i,3), k5(i,1)./10, k5(i,2)./10, k5(i,3)./10, 'b');
end
%pie izquierdo
for i = 1:20:length(p15)
    quiver3(CMPfootL(i,1),CMPfootL(i,2), CMPfootL(i,3), i6(i,1)./10, i6(i,2)./10, i6(i,3)./10, 'r');
    hold on;
    quiver3(CMPfootL(i,1),CMPfootL(i,2), CMPfootL(i,3), j6(i,1)./10, j6(i,2)./10, j6(i,3)./10, 'g');
    hold on;
    quiver3(CMPfootL(i,1),CMPfootL(i,2), CMPfootL(i,3), k6(i,1)./10, k6(i,2)./10, k6(i,3)./10, 'b');
end



xlabel('Eje X');
ylabel('Eje y');
zlabel ('Eje z');
title('GRAFICOS de IJK para miembros inferiores')
grid on;


%IJK nos da orientacion (inclinación) del segmento respecto de la habitacion
%uvw (DAN IDEA DE COMO SE MUEVEN LOS MARCADORES) usan marcadores para calcular los c articualres, preo no identifica en
%cada versor la inclinacion de un segmento, SOLO SIRVEN PARA CALCULAR IJK
%para generar ijk usamos toda la infromacion del segmento y los formamos a
%partir de los centros articulares


%% CALCULO DE ANGULOS ARTICULARES 

%calculo cadera derecha
acadeR = cross(khip,i1);
normcadR= sqrt(sum(acadeR.^2,2));
for i=1: size(acadeR,1)
    Ir_HJC(i,:)=acadeR(i,:)/normcadR(i);
end

%calculo cadera izquierda
acadeL = cross(khip,i2);
normcadL= sqrt(sum(acadeL.^2,2));
for i=1: size(acadeL,1)
    Il_HJC(i,:)=acadeL(i,:)/normcadL(i);
end

%angulo alfa para las caderas derecha e izquierda
p_ahr=dot(Ir_HJC,ihip,2);
p_ahl=dot(Il_HJC,ihip,2);
alfa_RHJC=asind(p_ahr);
alfa_LHJC=asind(p_ahl);

%angulo beta para las caderas derecha e izquierda
p_bhr=dot(khip,i1,2);
p_bhl=dot(khip,i2,2);
beta_RHJC=asind(p_bhr);
beta_LHJC=-asind(p_bhl);

%angulo gamma para las caderas derecha e izquierda
p_ghr=dot(Ir_HJC,k1,2);
p_ghl=dot(Il_HJC,k2,2);
gamma_RHJC=-asind(p_ghr);
gamma_LHJC=asind(p_ghl);


%% angulos articulares para rodillas
%calculo rodilla derecha
arodR = cross(k1,i3);
normrodR= sqrt(sum(arodR.^2,2));
for i=1: size(arodR,1)
    Ir_KJC(i,:)=arodR(i,:)/normrodR(i);
end

%calculo rodilla izquierda
arodL = cross(k2,i4);
normrodL= sqrt(sum(arodL.^2,2));
for i=1: size(arodL,1)
    Il_KJC(i,:)=arodL(i,:)/normrodL(i);
end

%angulo alfa para las rodilla derecha e izquierda
p_akr=dot(Ir_KJC,i1,2);
p_akl=dot(Il_KJC,i2,2);
alfa_RKJC=-asind(p_akr);
alfa_LKJC=-asind(p_akl);

%angulo beta para las rodilla derecha e izquierda
p_bkr=dot(k1,i3,2);
p_bkl=dot(k2,i4,2);
beta_RKJC=asind(p_bkr);
beta_LKJC=-asind(p_bkl);

%angulo gamma para las rodilla derecha e izquierda
p_gkr=dot(Ir_KJC,k3,2);
p_gkl=dot(Il_KJC,k4,2);
gamma_RKJC=-asind(p_gkr);
gamma_LKJC=asind(p_gkl);


%% angulos articulares para tobillos
%calculo tobillo derecho
atobR = cross(k3,i5);
normtobR= sqrt(sum(atobR.^2,2));
for i=1: size(atobR,1)
    Ir_AJC(i,:)=atobR(i,:)/normtobR(i);
end

%calculo tobillo derecho
atobL = cross(k4,i6);
normtobL= sqrt(sum(atobL.^2,2));
for i=1: size(atobL,1)
    Il_AJC(i,:)=atobL(i,:)/normtobL(i);
end

%angulo alfa para los tobillos derecho e izquierdo
p_aar=dot(Ir_AJC,j3,2);
p_aal=dot(Il_AJC,j4,2);
alfa_RAJC=-asind(p_aar);
alfa_LAJC=-asind(p_aal);
%angulo beta para los tobillos derecho e izquierdo
p_bar=dot(k3,i5,2);
p_bal=dot(k4,i6,2);
beta_RAJC=asind(p_bar);
beta_LAJC=-asind(p_bal);
%angulo gamma para los tobillos derecho e izquierdo
p_gar=dot(Ir_AJC,k5,2);
p_gal=dot(Il_AJC,k6,2);
gamma_RAJC=asind(p_gar);
gamma_LAJC=-asind(p_gal);


%% RECORTES

%cadera derecha
alfa_Rhip=alfa_RHJC(1:RHS2-inicio);
[Alfa_Rhip]=InterpolaA100Muestras(alfa_Rhip);

beta_Rhip=beta_RHJC(1:RHS2-inicio);
[Beta_Rhip]=InterpolaA100Muestras(beta_Rhip);

gamma_Rhip=gamma_RHJC(1:RHS2-inicio);
[Gamma_Rhip]=InterpolaA100Muestras(gamma_Rhip);

%rodilla derecha
alfa_Rknee=alfa_RKJC(1:RHS2-inicio);
[Alfa_Rknee]=InterpolaA100Muestras(alfa_Rknee);

beta_Rknee=beta_RKJC(1:RHS2-inicio);
[Beta_Rknee]=InterpolaA100Muestras(beta_Rknee);

gamma_Rknee=gamma_RKJC(1:RHS2-inicio);
[Gamma_Rknee]=InterpolaA100Muestras(gamma_Rknee);

%tobillo derecho
alfa_Rankle=alfa_RAJC(1:RHS2-inicio);
[Alfa_Rankle]=InterpolaA100Muestras(alfa_Rankle);

beta_Rankle=beta_RAJC(1:RHS2-inicio);
[Beta_Rankle]=InterpolaA100Muestras(beta_Rankle);

gamma_Rankle=gamma_RAJC(1:RHS2-inicio);
[Gamma_Rankle]=InterpolaA100Muestras(gamma_Rankle);


%cadera izquierda
alfa_Lhip=alfa_LHJC(LHS1-inicio:LHS2-inicio);
[Alfa_Lhip]=InterpolaA100Muestras(alfa_Lhip);
beta_Lhip=beta_LHJC(LHS1-inicio:LHS2-inicio);
[Beta_Lhip]=InterpolaA100Muestras(beta_Lhip);
gamma_Lhip=gamma_LHJC(LHS1-inicio:LHS2-inicio);
[Gamma_Lhip]=InterpolaA100Muestras(gamma_Lhip);

%rodilla izquierda
alfa_Lknee=alfa_LKJC(LHS1-inicio:LHS2-inicio);
[Alfa_Lknee]=InterpolaA100Muestras(alfa_Lknee);

beta_Lknee=beta_LKJC(LHS1-inicio:LHS2-inicio);
[Beta_Lknee]=InterpolaA100Muestras(beta_Lknee);

gamma_Lknee=gamma_LKJC(LHS1-inicio:LHS2-inicio);
[Gamma_Lknee]=InterpolaA100Muestras(gamma_Lknee);

%tobillo izquierdo
alfa_Lankle=alfa_LAJC(LHS1-inicio:LHS2-inicio);
[Alfa_Lankle]=InterpolaA100Muestras(alfa_Lankle);

beta_Lankle=beta_LAJC(LHS1-inicio:LHS2-inicio);
[Beta_Lankle]=InterpolaA100Muestras(beta_Lankle);

gamma_Lankle=gamma_LAJC(LHS1-inicio:LHS2-inicio);
[Gamma_Lankle]=InterpolaA100Muestras(gamma_Lankle);

%% PLOT DE LOS ANGULOS
% cadera
subplot(3,3,1);plot(Alfa_Rhip,'r', 'LineWidth',2);hold on; plot(Alfa_Lhip,'b','LineWidth',2);
title('Angulo de flexion (+) y extension (-) de cadera')
ylabel('Grados');
grid on;

subplot(3,3,2);plot(Beta_Rhip,'r', 'LineWidth',2);hold on; plot(Beta_Lhip,'b','LineWidth',2);
title('Angulo de abduccion (+) y aduccion (-) de cadera')
ylabel('Grados');
grid on;

subplot(3,3,3);plot(Gamma_Rhip,'r', 'LineWidth',2);hold on; plot(Gamma_Lhip,'b','LineWidth',2);
title('Angulo de rotacion interna (+) y rotacion externa (-) de cadera')
ylabel('Grados');
grid on;


%rodilla
subplot(3,3,4);plot(Alfa_Rknee,'r', 'LineWidth',2);hold on; plot(Alfa_Lknee,'b','LineWidth',2);
title('Angulo de flexion (+) y extension (-) de rodilla')
ylabel('Grados');
grid on;

subplot(3,3,5);plot(Beta_Rknee,'r', 'LineWidth',2);hold on; plot(Beta_Lknee,'b','LineWidth',2);
title('Angulo de abduccion (+) y aduccion (-) de rodilla')
ylabel('Grados');
grid on;

subplot(3,3,6);plot(Gamma_Rknee,'r', 'LineWidth',2);hold on; plot(Gamma_Lknee,'b','LineWidth',2);
title('Angulo de rotacion interna (+) y rotacion externa (-) de rodilla')
ylabel('Grados');
grid on;


% tobillo
subplot(3,3,7);plot(Alfa_Rankle,'r', 'LineWidth',2);hold on; plot(Alfa_Lankle,'b','LineWidth',2);
title('Angulo de flexion (+) y extension (-) de tobillo')
ylabel('Grados');
grid on;

subplot(3,3,8);plot(Gamma_Rankle,'r', 'LineWidth',2);hold on; plot(Gamma_Lankle,'b','LineWidth',2);
title('Angulo de abduccion (+) y aduccion (-) de tobillo')
ylabel('Grados');
grid on;

subplot(3,3,9);plot(Beta_Rankle,'r', 'LineWidth',2);hold on; plot(Beta_Lankle,'b','LineWidth',2);
title('Angulo de rotacion interna (+) y rotacion externa (-) de tobillo')
ylabel('Grados');
grid on;


%% ANGULOS DE EULER

[alfasen1,alfacos1,betasen1,betacos1,gammasen1,gammacos1]=anguloeuler(i1,j1,k1);
[alfasen2,alfacos2,betasen2,betacos2,gammasen2,gammacos2]=anguloeuler(i2,j2,k2);
[alfasen3,alfacos3,betasen3,betacos3,gammasen3,gammacos3]=anguloeuler(i3,j3,k3);
[alfasen4,alfacos4,betasen4,betacos4,gammasen4,gammacos4]=anguloeuler(i4,j4,k4);
[alfasen5,alfacos5,betasen5,betacos5,gammasen5,gammacos5]=anguloeuler(i5,j5,k5);
[alfasen6,alfacos6,betasen6,betacos6,gammasen6,gammacos6]=anguloeuler(i6,j6,k6);

%muslo derecho
alfa1=1;
beta1=1;
gamma1=1;
%muslo izquierdo
alfa2=1;
beta2=1;
gamma2=1;

%pierna derecha
alfa3=1;
beta3=1;
gamma3=1;
%pierna izquierda
alfa4=1;
beta4=1;
gamma4=1;

%pie derecho
alfa5=1;
beta5=1;
gamma5=1;
%pie izquierdo
alfa6=1;
beta6=1;
gamma6=1;

%derivadas de los angulos








