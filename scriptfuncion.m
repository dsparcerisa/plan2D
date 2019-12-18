E0 = 3; %MeV
Z = [0:0.1:10]; %distancia de 0 a 10 cm
[energyW, energyA, stoppingPowerAir, stoppingPowerWater] = energyStoppingPower(E0,Z);