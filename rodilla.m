%%calculo u,v,w de rodilla para centro articular
%RODILLA DERECHA
%calculo de v de rodilla
RAvp= p3-p5; %[x y z]
RBvp= RAvp.^2; %Elevo todo al cuadrado x^2,y^2,z^2
Rnormvp= sqrt(sum(RBvp,2)); %Aplico raiz para calcular la norma (proceso que se hace fila por fila)

for i=1: size(RAvp,1)
    Rvrodilla(i,:)=RAvp(i,:)/Rnormvp(i);
end

%calculo de u de rodilla
RAu=(p7-p15);
RBu=(p14-p15);
RCu = cross(RAu,RBu);
Rnormwp= sqrt(sum(RCu.^2,2));
for i=1: size(RAu,1)
    Rurodilla(i,:)=RCu(i,:)/Rnormup(i);
end

%calculo de w de rodilla
Rwrodilla= cross(Rvrodilla,Rurodilla);

%% centro articular rodilla derecha
prknee = p5 + A11*Rurodilla + A11*Rvrodilla + 0.5*A11*Rwrodilla;


%% RODILLA IZQUIERDA
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
Lnormwp= sqrt(sum(LCu.^2,2));
for i=1: size(LAu,1)
    Lurodilla(i,:)=LCu(i,:)/Lnormup(i);
end

%calculo de w de rodilla
Lwrodilla= cross(Lvrodilla,Lurodilla);

%% centro articular rodilla izquierda
plknee= p12 + A12*Lurodilla + A12*Lvrodilla - 0.5**A12*Lwrodilla;
