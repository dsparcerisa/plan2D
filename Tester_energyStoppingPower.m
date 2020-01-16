
airTable = csvread('air10MeV.csv');
airTable = airTable(:, 1:2);
waterTable = csvread('water10MeV.csv');
airTable = airTable(:, 1:2);

E0 = 3;
Z = 0:0.001:20;

tic
[energyA, stoppingPowerAir, stoppingPowerWater] = energyStoppingPower(E0,Z, airTable, waterTable);
toc

subplot(3,1,1);
plot(Z,stoppingPowerAir);
subplot(3,1,2);
plot(Z,stoppingPowerWater);
subplot(3,1,3);
plot(Z,energyA);
