% Esta función sirve para calcular un vector entre dos puntos, 
% los asis izquierdo y derecho en el espacio 3D y lo grafica. También grafica solapado con ese mismo vector 
% en otro color el vector convertido a versor unitario (1 metro de longitud)  
% asimismo, usando el producto cruz calcula un vector perpendicular a tres
% puntos sacro, asis izquierdo y derecho y de igual forma lo grafica en 3D
% como vector y como versor unitario en otro color se grafica en la misma
% figura. Finalmente calcula un tercer versor perpendicular a los dos
% anteriores lo que daría un sistema de tres versores ortonormles entre sí.
% Este tercer versor se grafica también todo en una misma figura.
% IMPORTANTE: Todo este código es usando "SIN" usar bucles con "for"
% esto requiere dos funciones adicionales para la graficación no se utiliza una función 
% aparte lo que podría resultar conveniente      
% IMPORTANTE2: tener en cuenta que esta escrita con los marcadores
% organizados en una estructura "Datos.Pasada.Marcadores.Crudos.Valores" esto puede
% haber definido usted que sea otra forma de estructura, debe adaptarla
function [] = VectoresSinFor(Datos);

frames=length(Datos.Pasada.Marcadores.Crudos.Valores.sacrum);
v=Datos.Pasada.Marcadores.Crudos.Valores.l_asis-Datos.Pasada.Marcadores.Crudos.Valores.r_asis; %Vector de ASIS derecho a Izquierdo
vnormalizado=ConvierteVectorAVersor(v); %divido por norma para convertir el vector a versor
figure;
Origen=Datos.Pasada.Marcadores.Crudos.Valores.r_asis;
plot3(Origen(1,1),Origen(1,2),Origen(1,3),'r');
hold on;
grid on;
for nframe=1:10:frames
plot3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),'r');
quiver3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),v(nframe,1),v(nframe,2),v(nframe,3),'r','LineWidth',6);

end

for nframe=1:10:frames
plot3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),'b');
quiver3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),vnormalizado(nframe,1),vnormalizado(nframe,2),vnormalizado(nframe,3),'b');

end

% w = zeros(frames,3);
% wnormalizado= zeros(frames,3);
w=cross(Datos.Pasada.Marcadores.Crudos.Valores.r_asis-Datos.Pasada.Marcadores.Crudos.Valores.sacrum,Datos.Pasada.Marcadores.Crudos.Valores.l_asis-Datos.Pasada.Marcadores.Crudos.Valores.sacrum);
wnormalizado=ConvierteVectorAVersor(w);%divido por norma para convertir el vector a versor
Origen=Datos.Pasada.Marcadores.Crudos.Valores.r_asis;
plot3(Origen(1,1),Origen(1,2),Origen(1,3),'g');

for nframe=1:10:frames
plot3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),'r');
quiver3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),w(nframe,1),w(nframe,2),w(nframe,3),'g','LineWidth',6);
end

for nframe=1:10:frames
plot3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),'k');
quiver3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),wnormalizado(nframe,1),wnormalizado(nframe,2),wnormalizado(nframe,3),'k');
end
unormalizado=cross(vnormalizado,wnormalizado);
for nframe=1:10:frames
plot3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),'m');
quiver3(Origen(nframe,1),Origen(nframe,2),Origen(nframe,3),unormalizado(nframe,1),unormalizado(nframe,2),unormalizado(nframe,3),'m');
end
