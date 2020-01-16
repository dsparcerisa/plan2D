function doseMap = getDoseMap(E0, z, dz, Nprot, targetTh, targetDens, targetSPR, N0)
% CG2D doseMap = getDoseMap(double E0, double z, double dz, double Nprot, 
%  double targetTh, double targetDens, double targetSPR, CG2D N0)

[sigma, Sw_z] = getSandE(E0, z, dz);
NZ = convFluence(N0, sigma);

MeV2J = 1.602e-13;

E_Mev = Nprot*NZ.data*(Sw_z*targetSPR)*targetTh;
E_J = E_Mev * MeV2J;

m_1voxel_g = (N0.dx * N0.dy * targetTh) * targetDens;
m_1voxel_kg = m_1voxel_g / 1000;

D = E_J ./ m_1voxel_kg;

doseMap = CartesianGrid2D(N0);
doseMap.data = D;

end

