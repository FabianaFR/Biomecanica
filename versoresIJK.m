%% SEGMENTO PELVIS
ihip = wpelvis;
jhip = upelvis;
khip = vpelvis;

%% SEGMENTO MUSLO DERECHO
% versor i
imusAr= prhip - prknee;
imusBr= imusAr.^2;
iMRnorma= sqrt(sum(imusBr,2));
for i=1: size(imusAr,1)
    i1(i,:)=imusAr(i,:)/iMRnorma(i); % imusR versor i para el muslo derecho
end

% versor j
jmusAr=(p6-prhip);
jmusBr=(prknee-prhip);
jmusCr = cross(jmusAr,jmusBr);
jMRnorma= sqrt(sum(jmusCr.^2,2));
for i=1: size(jmusAr,1)
    j1(i,:)=jmusCr(i,:)/jMRnorma(i); % jmusR versor j para el mulso derecho
end

% versor k
k1= cross(i1,j1); % kmusR versor k para el muslo derecho



%% SEGMENTO MUSLO IZQUIERDO
% versor i
imusAl= plhip - plknee;
imusBl= imusAl.^2;
iMLnorma= sqrt(sum(imusBl,2));
for i=1: size(imusAl,1)
    i2(i,:)=imusAl(i,:)/iMLnorma(i); % imusL versor i para el muslo izquierdo
end

% versor j
jmusAl=(plknee-plhip);
jmusBl=(p13-plhip);
jmusCl = cross(jmusAl,jmusBl);
jMLnorma= sqrt(sum(jmusCl.^2,2));
for i=1: size(jmusAl,1)
    j2(i,:)=jmusCl(i,:)/jMLnorma(i); % jmusR versor j para el mulso izquierdo
end

% versor k
k2= cross(i2,j2); % kmusR versor k para el muslo izquierdo


%% GRAFICAS DE IJK PARA MUSLOS
figure;
plot3(p15(;,1),p15(;,2), p15(;,3),'k','LineWidth',2)
hold on;
plot3(CMPmusR(;,1),CMPmusR(;,2), CMPmusR(;,3),'r','LineWidth',2)
hold on;
plot3(CMPmusL(;,1),CMPmusL(;,2), CMPmusL(;,3),'b','LineWidth',2)
hold on;

for i = 1:20:length(p15)
    quiver3(p15(i,1),p15(i,2), p15(i,3), ihip(i,1)./10, ihip(i,2)./10, ihip(i,3)./10, 'r');
    hold on;
    quiver3(p15(i,1),p15(i,2), p15(i,3), jhip(i,1)./10, jhip(i,2)./10, jhip(i,3)./10, 'g');
    hold on;
    quiver3(p15(i,1),p15(i,2), p15(i,3), khip(i,1)./10, khip(i,2)./10, khip(i,3)./10, 'b');
end

for i = 1:20:length(p15)
    quiver3(CMPmusR(i,1),CMPmusR(i,2), CMPmusR(i,3), i1(i,1)./10, i1(i,2)./10, i1(i,3)./10, 'r');
    hold on;
    quiver3(CMPmusR(i,1),CMPmusR(i,2), CMPmusR(i,3), j1(i,1)./10, j1(i,2)./10, j1(i,3)./10, 'g');
    hold on;
    quiver3(CMPmusR(i,1),CMPmusR(i,2), CMPmusR(i,3), k1(i,1)./10, k1(i,2)./10, k1(i,3)./10, 'b');
end

for i = 1:20:length(p15)
    quiver3(CMPmusL(i,1),CMPmusL(i,2), CMPmusL(i,3), i2(i,1)./10, i2(i,2)./10, i2(i,3)./10, 'r');
    hold on;
    quiver3(CMPmusL(i,1),CMPmusL(i,2), CMPmusL(i,3), j2(i,1)./10, j2(i,2)./10, j2(i,3)./10, 'g');
    hold on;
    quiver3(CMPmusL(i,1),CMPmusL(i,2), CMPmusL(i,3), k2(i,1)./10, k2(i,2)./10, k2(i,3)./10, 'b');
end

legend('marcador sacro', 'centro masa mus derecho', 'centro masa mus izquierdo', 'i de pelvis','j de pelvis','k de pelvis');
xlabel('Eje x');
ylabel('Eje y');
zlabel('Eje z');
title('Trayectoria de marcadores, centros de masa y versores ijk de pelvis y muslo D y I');
grid on;





