%--------------------------------------------------------------------------
% %% Centro articular de Caderas (DAVIS)
    Beta2=Datos.Pasada.Marcadores.filtrados.l_asis-Datos.Pasada.Marcadores.filtrados.r_asis; %Vector de ASIS derecho a Izquierdo
    epy=aVersor(Beta2);%divido por norma para convertir el vector a versor
    
    PmedioAsis=(Datos.Pasada.Marcadores.filtrados.l_asis+Datos.Pasada.Marcadores.filtrados.r_asis).*0.5;
    Beta1= PmedioAsis- Datos.Pasada.Marcadores.filtrados.sacrum ; %Vector de ASIS derecho a Izquierdo
    aux=dot(Beta1,epy,2);
    aux1= (epy(:,1)).*(aux);
    aux2= (epy(:,2)).*(aux);
    aux3= (epy(:,3)).*(aux);
    aux= [aux1 aux2 aux3];
    Beta3= Beta1 - aux;
    epx=aVersor(Beta3);%divido por norma para convertir el vector a versor
    epz=cross(epx,epy);%versor 2×3-->1  ;-)
    epz=aVersor(epz);%divido por norma para convertir el vector a versor
    TitaDavis=28.4*pi/180;
    BetaDavis=18*pi/180;
    C=0.115*(LONGITUD_PIERNA_DERECHA+LONGITUD_PIERNA_IZQUIERDA)*0.5-0.0153;
    
    XH = (-PROFUNDIDAD_PELVIS)*cos(BetaDavis)+C*cos(TitaDavis)*sin(BetaDavis);
    YH = C*sin(TitaDavis)-LONGITUD_ASIS/2;
    ZH = (-PROFUNDIDAD_PELVIS)*sin(BetaDavis)-C*cos(TitaDavis)*cos(BetaDavis);
    Datos.Pasada.CA_Davis.cadera_d=PmedioAsis+epx.*XH+epy.*YH+epz.*ZH; %me desplazo desde el punto medio de los ASIS direcciones de epx, epy y epz un porcentaje del ancho de la pelvis (de ASIS a ASIS) y profundifad de pelvis;
    Datos.Pasada.CA_Davis.cadera_i=PmedioAsis+epx.*XH-epy.*YH+epz.*ZH; %me desplazo desde el punto medio de los ASIS direcciones de epx, epy y epz un porcentaje del ancho de la pelvis (de ASIS a ASIS) y profundifad de pelvis;
    

%--------------------------------------------------------------------------

