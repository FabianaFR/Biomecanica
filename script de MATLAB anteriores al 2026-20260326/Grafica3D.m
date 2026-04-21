function [] = Grafica3D(QueGrafico,color,ancho);

plot3(QueGrafico(:,1),QueGrafico(:,2),QueGrafico(:,3),'color',color,'linewidth',ancho);
%pause;
%comet3(QueGrafico(:,1),QueGrafico(:,2),QueGrafico(:,3));