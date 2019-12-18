function [energyW, energyA, stoppingPowerAir, stoppingPowerWater] = energyStoppingPower(E0,Z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
airTable = csvread('C:\Users\ire-cris\Documents\GitHub\plan2D\air.csv');
waterTable = csvread('C:\Users\ire-cris\Documents\GitHub\plan2D\water.csv');

energy_Air = airTable(:,1); %Energ�a en MeV
stoppingPower_Air = airTable(:,2); %Poder de frenado en MeV cm2/g

rho_Air = 1.20479*10^(-3); %densidad del aire
stoppingPower_Air = stoppingPower_Air*rho_Air; %obtenemos el poder de frenado en (MeV/cm)

energy_Water = waterTable(:,1);
stoppingPower_Water = waterTable(:,2);

rho_Water = 1; %densidad del aire
stoppingPower_Water = stoppingPower_Water*rho_Water;

%Creamos unos vectores iniciales para la energ�a y el poder de frenado que sean del tama�o de Z
energiesAir_Z = nan(size(Z));
stoppingPowerAir_Z = nan(size(Z));
energiesAir_Z(1) = E0;
stoppingPowerAir_Z(1) = interp1(energy_Air, stoppingPower_Air, E0); %interpolamos para que el valor del poder de frenado se corresponda con la energ�a

energiesWater_Z = nan(size(Z));
stoppingPowerWater_Z = nan(size(Z));
energiesWater_Z(1) = E0;
stoppingPowerWater_Z(1) = interp1(energy_Water, stoppingPower_Water, E0);

for i=2:numel(Z) %hasta el n�mero de elementos de Z
    
    stoppingPowerAir_Z(i) =  interp1(energy_Air,stoppingPower_Air, energiesAir_Z(i-1));
    energiesAir_Z(i) = energiesAir_Z(i-1) - stoppingPowerAir_Z(i-1)*(Z(i) - Z(i-1)); %la energ�a a una distancia determinada ser� igual a la energ�a inicial (3 Mev) menos la energ�a que pierde al desplazarse de Z1 a Z2 ((dE/dz)*z)
    
    stoppingPowerWater_Z(i) = interp1(energy_Water,stoppingPower_Water, energiesWater_Z(i-1)); %energ�a negativas
    energiesWater_Z(i) = energiesWater_Z(i-1) - stoppingPowerWater_Z(i-1)*(Z(i) - Z(i-1)); %la energ�a a una distancia determinada ser� igual a la energ�a inicial (3 Mev) menos la energ�a que pierde al desplazarse de Z1 a Z2 ((dE/dz)*z)

end

figure(1)
plot(Z,stoppingPowerAir_Z);
xlabel('z (cm)');
ylabel('Stopping Power (MeV/cm)');
title('Bragg Curve (Air)');

figure(2)
plot(Z,energiesAir_Z);
xlabel('z (cm)');
ylabel('Energy (MeV)');
title('Energy (Air)');

figure(3)
plot(Z,stoppingPowerWater_Z);
xlabel('z (cm)');
ylabel('Stopping Power (MeV/cm)');
title('Bragg Curve (Water)');

figure(4)
plot(Z,energiesWater_Z);
xlabel('z (cm)');
ylabel('Energy (MeV)');
title('Energy (Water)');

stoppingPowerAir = stoppingPowerAir_Z;
stoppingPowerWater = stoppingPowerWater_Z;
energyW = energiesWater_Z;
energyA = energiesAir_Z;
   

end

