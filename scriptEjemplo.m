energyTable = [1.000E+00 2.608E+02 
2.000E+00 1.586E+02 
3.000E+00 1.172E+02 
4.000E+00 9.404E+01 
5.000E+00 7.911E+01 
6.000E+00 6.858E+01];
energies_Tab = energyTable(:,1); S_Tab = energyTable(:, 2);
rho_W = 1; 
S_Tab = S_tab * rho_W; 

Zpos = [0:0.001:10];
E0 = 5;
Energies_Z = nan(size(Zpos));
stoppingPower = nan(size(Zpos));

Energies_Z(1) = E0;
stoppingPower(1) = interp1(energies_Tab, S_Tab, E0);

for i=2:numel(Zpos)
    stoppingPower(i) = interp(energies_Tab, S_Tab, Energies_Z(i-1);
    Energies_Z(i) = Energies_Z(i-1) - stoppingPower(i-1)*(Zpos(i) - Zpos(i-1));
end
        