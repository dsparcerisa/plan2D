function doseMap = getDoseMap(dx, dy, sizeX, sizeY, E0, z, Nprot, targetTh, targetSPR)
% CG2D doseMap = getDoseMap(double E0, double z, double dz, double Nprot, 
% double targetTh, double targetDens, double targetSPR, CG2D N0)

[FluenceProfile] = createFluenceProfile(dx,dy, sizeX, sizeY, E0, z);

[energyA, stoppingPowerAir, stoppingPowerWater] = energyStoppingPower(E0, 0:0.0001:z);
Sw_z = stoppingPowerWater(end);


MeV2J = 1.602e-13;
 
E_Mev = Nprot*FluenceProfile.data*(Sw_z*targetSPR)*targetTh;
E_J = E_Mev * MeV2J;
 
m_1voxel_g = (dx * dy * targetTh);
m_1voxel_kg = m_1voxel_g / 1000;
 
D = E_J ./ m_1voxel_kg;
 
doseMap = createEmptyCG2D(dx,dy, sizeX, sizeY);
doseMap.data = D;
end

