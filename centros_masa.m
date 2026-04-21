%% CALCULO DE CENTROS DE MASA DEL MUSLO - PIERNA - PIE
CMPmusR = prhip + 0.39*(rpknee - prhip)
CMPmusL = plhip + 0.39*(lpknee - plhip)

CMPcalfR = prknee + 0.42*(prtobillo - prknee)
CMPcalfL = plknee + 0.42*(pltobillo - plknee)

CMPfootR = p2 + 0.44*(prtoe-p2)
CMPfootL = p9 + 0.44*(pltoe-p9)


%% GRAFICAS DE LOS CENTROS DE MASA DERECHOS
figure;
plot3(prhip(;,1), prhip(;,2),prhip(;,3),'g','LineWidth',2)
hold on;
plot3(CMPmusR(;,1), CMPmusR(;,2),CMPmusR(;,3),'r--','LineWidth',2)
hold on;
plot3(prknee(;,1), prknee(;,2),prknee(;,3),'b','LineWidth',2)
hold on;
plot3(CMPcalfR(;,1), CMPcalfR(;,2),CMPcalfR(;,3),'r--','LineWidth',2)
hold on;
plot3(prtobillo(;,1), prtobillo(;,2),prtobillo(;,3),'b','LineWidth',2)
hold on;
plot3(CMPfootR(;,1), CMPfootR(;,2),CMPfootR(;,3),'r--','LineWidth',2)
xlabel('Eje x');
ylabel('Eje y');
zlabel('Eje z');
grid on;
title('Trayectoria de articulaciones y centros de masa del miembro inferior derecho');
legend('Centro articular cadera', 'centro de masa del muslo', 'Centro articular de rodilla', 'centro de masa pierna', 'centro articular tobillo', 'centro de masa del pie');
hold off;



%% GRAFICAS DE LOS CENTRO DE MASA IZQUIERDOS
figure;
plot3(plhip(;,1), plhip(;,2),plhip(;,3),'g','LineWidth',2)
hold on;
plot3(CMPmusL(;,1), CMPmusL(;,2),CMPmusL(;,3),'r--','LineWidth',2)
hold on;
plot3(plknee(;,1), plknee(;,2),plknee(;,3),'b','LineWidth',2)
hold on;
plot3(CMPcalfL(;,1), CMPcalfL(;,2),CMPcalfL(;,3),'r--','LineWidth',2)
hold on;
plot3(pltobillo(;,1), pltobillo(;,2),pltobillo(;,3),'b','LineWidth',2)
hold on;
plot3(CMPfootL(;,1), CMPfootL(;,2),CMPfootL(;,3),'r--','LineWidth',2)
xlabel('Eje x');
ylabel('Eje y');
zlabel('Eje z');
grid on;
title('Trayectoria de articulaciones y centros de masa del miembro inferior izquierdo');
legend('Centro articular cadera', 'centro de masa del muslo', 'Centro articular de rodilla', 'centro de masa pierna', 'centro articular tobillo', 'centro de masa del pie');
hold off;