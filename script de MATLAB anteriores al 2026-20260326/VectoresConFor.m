% Esta función sirve para calcular un vector entre dos puntos, 
% los asis izquierdo y derecho en el espacio 3D y lo grafica. También grafica solapado con ese mismo vector 
% en otro color  el vector convertido a versor unitario (1 metro de longitud)  
% asimismo  usando el producto cruz calcula un vector perpendicular a tres
% puntos sacro, asis izquierdo y derecho y de igual forma lo grafica en 3D
% como vector y como versor unitario en otro color se grafica en una
% segunda figura IMPORTANTE: Todo este código es usando bucles CON "for"
% para la graficación no se utiliza una función aparte lo que podría
% resultar conveniente
% IMPORTANTE2: tener en cuenta que esta escrita con los marcadores
% organizados en una estructura "Datos.Pasada.Marcadores.Crudos.Valores" esto puede
% haber definido usted que sea otra forma de estructura, debe adaptarla
function [] = VectoresConFor(Datos);


frames=length(Datos.Pasada.Marcadores.Crudos.Valores.sacrum);
v = zeros(frames,3);
vnormalizado= zeros(frames,3);

for nframe=1:frames
    v(nframe,:)=Datos.Pasada.Marcadores.Crudos.Valores.l_asis(nframe,:)-Datos.Pasada.Marcadores.Crudos.Valores.r_asis(nframe,:); %Vector de ASIS derecho a Izquierdo
    vnormalizado(nframe,:)=v(nframe,:)/norm(v(nframe,:));%divido por norma para convertir el vector a versor
end
figure;
Origen=Datos.Pasada.Marcadores.Crudos.Valores.r_asis;
plot3(Origen(1,1),Origen(1,2),Origen(1,3),'r');
hold on;
grid on;
for nframe=1:10:frames
plot3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),'r');
quiver3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),v(nframe,1),v(nframe,2),v(nframe,3),'r');
%pause;
end

for nframe=1:10:frames
plot3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),'b');
quiver3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),vnormalizado(nframe,1),vnormalizado(nframe,2),vnormalizado(nframe,3),'b');
%pause;
end

%Vector Perpendicular a tres puntos
for nframe=1:frames
    w(nframe,:)=cross(Datos.Pasada.Marcadores.Crudos.Valores.r_asis(nframe,:)-Datos.Pasada.Marcadores.Crudos.Valores.sacrum(nframe,:),Datos.Pasada.Marcadores.Crudos.Valores.l_asis(nframe,:)-Datos.Pasada.Marcadores.Crudos.Valores.sacrum(nframe,:));
    wnormalizado(nframe,:)=w(nframe,:)/norm(w(nframe,:));%divido por norma para convertir el vector a versor
end

figure;
Origen=Datos.Pasada.Marcadores.Crudos.Valores.r_asis;
plot3(Origen(1,1),Origen(1,2),Origen(1,3),'r');
hold on;
grid on;
for nframe=1:10:frames
plot3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),'r');
quiver3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),w(nframe,1),w(nframe,2),w(nframe,3),'r');
%pause;
end

for nframe=1:10:frames
plot3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),'b');
quiver3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),wnormalizado(nframe,1),wnormalizado(nframe,2),wnormalizado(nframe,3),'b');
%pause;
end

    


