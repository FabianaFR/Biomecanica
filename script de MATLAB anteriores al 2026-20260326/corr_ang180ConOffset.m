% Suaviza los saltos de +PI a -PI rad (+-180 grados)
function ANGULO= corr_ang180ConOffset(vector)
aux=vector;
ANGULO=vector;
flag=-1;
flag2=-1;
flag3=1;

for i=2:length(vector)
    
    if ((aux(i-1)*aux(i)<0) && ((abs(aux(i)-aux(i-1)))>0.9*pi))
        DIF=ceil(abs(aux(i)-aux(i-1))/(2*pi));
        flag=flag*-1;
        flag2=1;
        flag3=-1;
    end
    if (flag==1 && (aux(i-1)*aux(i)<0) )
        flag2=flag2*-1;
    end
    if (flag==1 && flag2==-1)
        ANGULO(i)=aux(i)-(DIF*2*pi*aux(i)/(abs(aux(i))));
    end
    if (flag==1 && flag2==1 )
        ANGULO(i)=aux(i)+(DIF*2*pi*aux(i)/(abs(aux(i))));
    end
    
end

if (flag3==-1)
    ANGULO=corr_ang180ConOffset(ANGULO);
end


end


