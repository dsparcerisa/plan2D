function [CSDA] = getCSDA(E)
% CSDA Range cm in dry air, sea water level, for proton energies 1:10 MeV. Souerce: https://physics.nist.gov/PhysRefData/Star/Text/PSTAR.html

rho = 0.001225; %g/cm3
csda = [2.867E-03, 8.792E-03, 1.737E-02, 2.839E-02, 4.173E-02, 5.731E-02, 7.506E-02, 9.493E-02, 1.169E-01, 1.408E-01]; %g/cm2
CSDA = csda(E)/rho;