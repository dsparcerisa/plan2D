clear all
E0 = 2; %MeV
Z = [0:0.1:20]; %distancia de 0 a 10 cm
[energyA, stoppingPowerAir, stoppingPowerWater] = energyStoppingPower(E0,Z);