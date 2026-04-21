

function MediaMov=MediaMovil5p(Vector)
MediaMov=Vector;
Aux1 = zeros(length(Vector(:,1)),length(Vector(1,:)));
Aux2 = zeros(length(Vector(:,1)),length(Vector(1,:)));
Aux3 = zeros(length(Vector(:,1)),length(Vector(1,:)));
Aux4 = zeros(length(Vector(:,1)),length(Vector(1,:)));
Aux5 = zeros(length(Vector(:,1)),length(Vector(1,:)));
Aux6 = zeros(length(Vector(:,1)),length(Vector(1,:)));
Aux7 = zeros(length(Vector(:,1)),length(Vector(1,:)));
Aux8 = zeros(length(Vector(:,1)),length(Vector(1,:)));




Aux1(1:end-1,:) = Vector(2:end,:);
Aux2(1:end-2,:) = Vector(3:end,:);
Aux3(1:end-3,:) = Vector(4:end,:);
Aux4(1:end-4,:) = Vector(5:end,:);
Aux5(1:end-5,:) = Vector(6:end,:);
Aux6(1:end-6,:) = Vector(7:end,:);
Aux7(1:end-7,:) = Vector(8:end,:);
Aux8(1:end-8,:) = Vector(9:end,:);

Aux1= Vector.*(1)+Aux1.*(1)+Aux2.*(1)+Aux3.*(1)+Aux4.*(1)+Aux5.*(1)+Aux6.*(1)+Aux7.*(1)+Aux8.*(1);

MediaMov(5:end,:) = Aux1(1:end-4,:);
end

