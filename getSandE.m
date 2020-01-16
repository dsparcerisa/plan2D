function [sigma_XY, Sw_z] = getSandE(E0, z, dz)
% [double Ez, double Sw_z] = getSandE(double E0, double z, double dz)
% Returns sigma_XY (cm) and stopping power in water (MeV/cm) from initial energy
% E0 (MeV) and distance z (cm)

Zval = 0:dz:z;
[energyA, stoppingPowerAir, stoppingPowerWater] = energyStoppingPower(E0, Zval);

Sw_z = stoppingPowerWater(end);

load(fullfile('TOPAS','polyFlu.mat'), 'polyFlu');

sigma_XY = getSigma(polyFlu, E0, z);

end

