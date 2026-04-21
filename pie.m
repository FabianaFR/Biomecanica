%%calculo u,v,w de pies para centro articular

%% PIE DERECHO
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

%% centro articular pie derecho y tobillo derecho
prtoe = p3 + 0.742*A13*Rupie + 1.074*A15*Rvpie - 0.187*A19*Rwpie;
prtobillo = p3 + 0.016*A13*Rupie + 0.392*A15*Rvpie + 0.478*A17*Rwpie;


%% PIE IZQUIERDO
%calculo de u de pie
LTAup= p10-p12; %[x y z]
LTBup= LTAup.^2; %Elevo todo al cuadrado x^2,y^2,z^2
LTnormup= sqrt(sum(LTBup,2)); %Aplico raiz para calcular la norma (proceso que se hace fila por fila)

for i=1: size(LTAup,1)
    Lupie(i,:)=LTAup(i,:)/LTnormup(i);
end

%calculo de w de pie
LTAw=(p10-p12);
LTBw=(p11-p12);
LTCw = cross(LTAw,LTBw);
LTnormwp= sqrt(sum(LTCw.^2,2));
for i=1: size(LTAw,1)
    Lwpie(i,:)=LTCw(i,:)/LTnormwp(i);
end

%calculo de v de pie
Lvpie= cross(Lwpie,Lupie);

%% centro articular pie izquierdo y tobillo izquierdo
pltoe= p10 + 0.742*A14*Lupie + 1.074*A16*Lvpie + 0.187*A20*Lwpie;
pltobillo = p10 + 0.016*A14*Lupie + 0.392*A16*Lvpie - 0.478*A18*Lwpie;