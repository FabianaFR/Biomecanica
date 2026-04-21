%%Calculo de u,v,w PARA CENTRO ARTICULAR CADERA

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

%% CENTROS ARTICULARES
%Para el calculo de la posicion de la cadera derecha y de la izquierda...
prhip= p15+ 0.598*A2*upelvis - 0.344*A2*vpelvis - 0,290*A2*wpelvis;
plhip= p15+ 0.598*A2*upelvis + 0.344*A2*vpelvis - 0,290*A2*wpelvis;


%% Graficos de marcadores y versores
figure
plot3(p15(:,1),p15(:,2),p15(:,3),'k','LineWidth',2)
hold on;
plot3(p7(:,1),p7(:,2),p7(:,3),'r','LineWidth',2)
hold on;
plot3(p14(:,1),p14(:,2),p14(:,3),'b','LineWidth',2)
hold on;

% quiver permite graficar versores o vectores
for i=1:10:length(p15)
    quiver3(p15(i,1),p15(i,2),p15(i,3),upelvis(i,1)./10,upelvis(i,2)./10,upelvis(i,3)./10,'b');
    hold on;
    quiver3(p15(i,1),p15(i,2),p15(i,3),vpelvis(i,1)./10,vpelvis(i,2)./10,vpelvis(i,3)./10,'r');
    hold on;
    quiver3(p15(i,1),p15(i,2),p15(i,3),wpelvis(i,1)./10,wpelvis(i,2)./10,wpelvis(i,3)./10,'g');
    hold on;
end
legend('Marcador del Sacro', 'Marcador del ASIS derecho','Marcador del ASIS izquierdo','u de pelvis','v de pelvis','w de pelvis');
xlabel('Eje X');
ylabel('Eje y');
zlabel ('Eje z');
title('Trayectoria de marcadores y diagrama de u,v,w sobre el marcador sacro')
grid on;

